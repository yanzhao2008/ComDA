!   �e��Z�g���ˋz���ʓ��˗ʂ����� RAD_CG ���Z�o����B
! 99/05/xx �ۍ␪�G
! 99/07/23 �ۍ␪�G �����ύX�Asnw,nos ���܂Ƃ߂Čv�Z����悤�ɂ���B
! 99/08/04 �ۍ␪�G ��򂳂�ɓn���o�[�W�����t�B�b�N�X
!
!  �ꎞ�ԂɈ�x�����Ă΂��
!  ���ӁB���j�^�ʂ́Adaytime �����̒l�� 1 ���Ԃ̏d�݂����ĐώZ���Ă���B
!        ����ē��̏o�E���̓��t�߂́A���j�^�l�͉ߑ�]������Ă���B
!        �����ŏo�̓}�[�N�ɂ́AZ ������
!
      SUBROUTINE RAD_SHRT_ADD (
     I    NMAX            , NMAX_01         , 
     I    ABSORB_SHRT_NOS , ABSORB_SHRT_SNW , 
     I    RAD_INTO_SIB    , 
     I    DAYTIME_1HR       , 
     O    RAD_SHRT_NOS    , RAD_SHRT_SNW    ) 
!
! �L���m�s�[�E�n�ʁE��w���ꂼ��ɂ��āA
!   �e��Z�g���ˋz���ʓ��˗ʂ����� RAD_CG ���Z�o����B
!
! ���B���E�U�����A���E�ߐԂ̘a���Ƃ�B
! ( ���߂��镪�͊܂ށH�z�����̂݁H �ǂ���H)
!
      USE SIBPRM , ONLY : 
     1   IDX  , 
     1   ICG  , 
     1   IVN  , 
     1   IBD   
!
#ifdef MONYOS
      USE SIB_MONIT, ONLY : MONIT_SIB, ICN,ICS,INA, 
     1    IMONIT_LEVEL  , 
     1    IMONIT_FLUX_MRI   , 
     1    IMONIT_BUDJET ,
     1    IMONIT_ALL , IMONIT_ALMA
#endif
!
!      USE COM_STEP_SIB0109, only :
!     1    SCN_SIB0109_DELT_SR   


!
      IMPLICIT NONE
!
! ����
!
      INTEGER,INTENT(IN)    :: NMAX_01(3)
      INTEGER,INTENT(IN)    :: NMAX
!
      REAL(8),INTENT(IN)    :: DAYTIME_1HR(IDX) 
      REAL(8),INTENT(IN)    :: 
     1      ABSORB_SHRT_NOS  (IDX,ICG,IVN,IBD)   ,  ! �Z�g�̋z����
     1      ABSORB_SHRT_SNW  (IDX,ICG,IVN,IBD)   ,  ! �Z�g�̋z����
     1      RAD_INTO_SIB     (IDX,    IVN,IBD)      ! ��C���[����flux
!
! �o��
!
      REAL(8),INTENT(OUT)  ::  
     1      RAD_SHRT_NOS     (IDX,ICG)           ,  ! �Z�g�z����
     1      RAD_SHRT_SNW     (IDX,ICG)              ! �Z�g�z����
!
! ���[�N
!
      INTEGER               :: I
      INTEGER               :: IVEG    
      REAL(8)               :: WORK(IDX)
!
#ifdef MONYOS
      CHARACTER(7)      :: CMARK 
      REAL(8),PARAMETER :: ONE  =  1.D0 
!     REAL(8),PARAMETER :: ONEM = -1.D0 
#endif
!
      LOGICAL LFIRST
      DATA LFIRST /.TRUE./
!
      IF ( LFIRST ) THEN
        WRITE(6,*) 'RAD_SHRT_ADD 99/07 POCHAKA '
        LFIRST = .FALSE.
      ENDIF 
!
      DO 1000 IVEG = 1, ICG
      DO 1000 I    = 1,NMAX_01(3)
        RAD_SHRT_NOS(I,IVEG) 
     1     =  ABSORB_SHRT_NOS(I,IVEG,1,1) * RAD_INTO_SIB(I,1,1)   ! �����B
     1      + ABSORB_SHRT_NOS(I,IVEG,2,1) * RAD_INTO_SIB(I,2,1)   ! �ߐԒ��B
     2      + ABSORB_SHRT_NOS(I,IVEG,1,2) * RAD_INTO_SIB(I,1,2)   ! ���U��
     3      + ABSORB_SHRT_NOS(I,IVEG,2,2) * RAD_INTO_SIB(I,2,2)   ! �ߐԎU��
 1000 CONTINUE
!
! �� �� IVEG=2 �́A���[�ɓ���Z�g�B
!
      DO 2000 IVEG = 1, ICG
      DO 2000 I    = NMAX_01(2),NMAX 
        RAD_SHRT_SNW(I,IVEG) 
     1     =  ABSORB_SHRT_SNW(I,IVEG,1,1) * RAD_INTO_SIB(I,1,1)   ! �����B
     1      + ABSORB_SHRT_SNW(I,IVEG,2,1) * RAD_INTO_SIB(I,2,1)   ! �ߐԒ��B
     2      + ABSORB_SHRT_SNW(I,IVEG,1,2) * RAD_INTO_SIB(I,1,2)   ! ���U��
     3      + ABSORB_SHRT_SNW(I,IVEG,2,2) * RAD_INTO_SIB(I,2,2)   ! �ߐԎU��
 2000 CONTINUE
!
! --------------
! > �ڍ׃��j�^ <
! --------------
!
#ifdef MONYOS
!
      IF ( 
     1             IMONIT_LEVEL .GE. IMONIT_ALL   
     1        .OR. IMONIT_LEVEL .GE. IMONIT_FLUX_MRI 
     1        .OR. IMONIT_LEVEL .GE. IMONIT_ALMA
     1   ) THEN
!
! ����
!    �������Z�g���˗� DSWBL �͕ʂɐώZ
!
        DO I    = 1,NMAX
          WORK(I)
     1    = (  RAD_INTO_SIB(I,1,1)                               ! �����B
     2       + RAD_INTO_SIB(I,2,1)                               ! �ߐԒ��B
     3       + RAD_INTO_SIB(I,1,2)                               ! ���U��
     4       + RAD_INTO_SIB(I,2,2) )                             ! �ߐԎU��
     5       * DAYTIME_1HR(I)   
        ENDDO
!
        IF ( IMONIT_LEVEL .GE. IMONIT_ALL ) THEN
          CMARK = 'HSRDNTP' 
!         CALL MONIT_SIB ( CMARK , WORK ,ICN, SCN_SIB0109_DELT_SR, ONE )
          CALL MONIT_SIB ( CMARK , WORK ,ICN, ONE, ONE )
          CMARK = 'HSRDSTP' 
!         CALL MONIT_SIB ( CMARK , WORK ,ICS, SCN_SIB0109_DELT_SR, ONE )
          CALL MONIT_SIB ( CMARK , WORK ,ICS, ONE, ONE )
        ENDIF
!
        IF ( IMONIT_LEVEL .GE. IMONIT_BUDJET ) THEN
          CMARK = 'DSWBL' 
!         CALL MONIT_SIB ( CMARK , WORK ,INA, SCN_SIB0109_DELT_SR, ONE )
          CALL MONIT_SIB ( CMARK , WORK ,INA, ONE, ONE )
        ENDIF
!
        IF ( IMONIT_LEVEL .GE. IMONIT_ALMA ) THEN
          CMARK = 'A_SWDN' 
!         CALL MONIT_SIB ( CMARK , WORK ,INA, SCN_SIB0109_DELT_SR, ONE )
          CALL MONIT_SIB ( CMARK , WORK ,INA, ONE, ONE )
        ENDIF
!
      ENDIF
!
! ���� ( ��z���� )  
!    ������Z�g�� USWBL �͕ʂɐώZ
!
      IF ( 
     1           IMONIT_LEVEL .GE. IMONIT_ALL   
     1      .OR. IMONIT_LEVEL .GE. IMONIT_FLUX_MRI 
     1      .OR. IMONIT_LEVEL .GE. IMONIT_ALMA
     1   ) THEN
        DO I    = 1,NMAX_01(3)
          WORK(I)
     1     =   ( 1 - ABSORB_SHRT_NOS(I,1,1,1) 
     1             - ABSORB_SHRT_NOS(I,2,1,1) ) 
     1         * RAD_INTO_SIB(I,1,1)                               ! �����B
     2       + ( 1 - ABSORB_SHRT_NOS(I,1,2,1) 
     2             - ABSORB_SHRT_NOS(I,2,2,1) ) 
     2         * RAD_INTO_SIB(I,2,1)                               ! �ߐԒ��B
     3       + ( 1 - ABSORB_SHRT_NOS(I,1,1,2) 
     3             - ABSORB_SHRT_NOS(I,2,1,2) ) 
     3         * RAD_INTO_SIB(I,1,2)                               ! ���U��
     4       + ( 1 - ABSORB_SHRT_NOS(I,1,2,2) 
     4             - ABSORB_SHRT_NOS(I,2,2,2) ) 
     4         * RAD_INTO_SIB(I,2,2)                               ! �ߐԎU��
          WORK(I)=WORK(I) * DAYTIME_1HR (I) 
        ENDDO
!
        IF ( IMONIT_LEVEL .GE. IMONIT_BUDJET ) THEN
          CMARK = 'USWBL' 
!         CALL MONIT_SIB ( CMARK , WORK ,ICN, SCN_SIB0109_DELT_SR,-ONE)
          CALL MONIT_SIB ( CMARK , WORK ,ICN, ONE ,-ONE)
        ENDIF
!
        IF ( IMONIT_LEVEL .GE. IMONIT_ALL ) THEN 
          CMARK = 'HSRUNTP' 
!         CALL MONIT_SIB ( CMARK , WORK ,ICN, SCN_SIB0109_DELT_SR, ONE)
          CALL MONIT_SIB ( CMARK , WORK ,ICN, ONE, ONE)
        ENDIF
!
        IF ( IMONIT_LEVEL .GE. IMONIT_ALMA ) THEN 
          CMARK = 'A_SWUP' 
!         CALL MONIT_SIB ( CMARK , WORK ,ICN, SCN_SIB0109_DELT_SR, ONE)
          CALL MONIT_SIB ( CMARK , WORK ,ICN, ONE, ONE)
        ENDIF
!
        DO I    = NMAX_01(2),NMAX
          WORK(I) 
     1     =   ( 1 - ABSORB_SHRT_SNW(I,1,1,1) 
     1             - ABSORB_SHRT_SNW(I,2,1,1) ) 
     1         * RAD_INTO_SIB(I,1,1)                               ! �����B
     2       + ( 1 - ABSORB_SHRT_SNW(I,1,2,1) 
     2             - ABSORB_SHRT_SNW(I,2,2,1) ) 
     2         * RAD_INTO_SIB(I,2,1)                               ! �ߐԒ��B
     3       + ( 1 - ABSORB_SHRT_SNW(I,1,1,2) 
     3             - ABSORB_SHRT_SNW(I,2,1,2) ) 
     3         * RAD_INTO_SIB(I,1,2)                               ! ���U��
     4       + ( 1 - ABSORB_SHRT_SNW(I,1,2,2) 
     4             - ABSORB_SHRT_SNW(I,2,2,2) ) 
     4         * RAD_INTO_SIB(I,2,2)                               ! �ߐԎU��
          WORK(I) = WORK(I) * DAYTIME_1HR(I) 
        ENDDO
!
        IF ( IMONIT_LEVEL .GE. IMONIT_BUDJET ) THEN
          CMARK = 'USWBL' 
!          CALL MONIT_SIB ( CMARK , WORK ,ICS, SCN_SIB0109_DELT_SR, -ONE)
          CALL MONIT_SIB ( CMARK , WORK ,ICS, ONE, -ONE)
        ENDIF
!
        IF ( IMONIT_LEVEL .GE. IMONIT_ALL ) THEN
          CMARK = 'HSRUSTP' 
!         CALL MONIT_SIB ( CMARK , WORK ,ICS, SCN_SIB0109_DELT_SR, ONE )
          CALL MONIT_SIB ( CMARK , WORK ,ICS, ONE, ONE )
        ENDIF
!
        IF ( IMONIT_LEVEL .GE. IMONIT_ALMA ) THEN 
          CMARK = 'A_SWUP' 
!         CALL MONIT_SIB ( CMARK , WORK ,ICS, SCN_SIB0109_DELT_SR, ONE)
          CALL MONIT_SIB ( CMARK , WORK ,ICS, ONE , ONE)
        ENDIF
!
      ENDIF
!
#endif
      RETURN
      END
!=============================================================
      SUBROUTINE MR_RAD_SHRT_ADD 
!
      USE SIB_MONIT , ONLY : 
     1    IMONIT_LEVEL  , IMONIT_ALL ,
     1    IMONIT_BUDJET ,
     1    IMONIT_FLUX_MRI , IMONIT_ALMA
!
      IMPLICIT NONE
!
      CHARACTER( 7)  :: CMARK 
      CHARACTER(32)  :: CTITLE 
      CHARACTER(13)  :: CUNIT
!
      LOGICAL,SAVE ::  LFIRST 
      DATA LFIRST /.TRUE./
!
      IF ( LFIRST ) THEN
        WRITE(6,*) 'MONIT_REGIST_RAD_SHRT_ADD 00/09 POCHAKA'
        LFIRST = .FALSE. 
      ENDIF
!
      IF ( IMONIT_LEVEL .GE. IMONIT_BUDJET ) THEN
!
! �������Z�g
!
        CMARK  = 'DSWBL'           
        CTITLE = 'RAD SHRT DOWNWARD AT SIB TOP'    
        CUNIT  = 'W/M**2'
        CALL monit_regist_sib ( CMARK , CTITLE , CUNIT )
!
! ������Z�g
!
        CMARK = 'USWBL'           
        CTITLE = 'RAD SHRT UPWARD   AT SIB TOP'   ! 
        CUNIT  = 'W/M**2'
        CALL monit_regist_sib ( CMARK , CTITLE , CUNIT )
!
      ENDIF
!
      IF ( IMONIT_LEVEL .GE. IMONIT_ALL ) THEN
!
        CMARK = 'HSRDNTP' 
        CTITLE = 'RAD SHRT DOWNWARD AT SIB TOP (NOSNOW)'
        CUNIT  = 'W/M**2'
        CALL monit_regist_sib ( CMARK , CTITLE , CUNIT )
!
        CMARK = 'HSRUNTP' 
        CTITLE = 'RAD SHRT UPWARD   AT SIB TOP (NOSNOW)'
        CUNIT  = 'W/M**2'
        CALL monit_regist_sib ( CMARK , CTITLE , CUNIT )
!
        CMARK = 'HSRDSTP' 
        CTITLE = 'RAD SHRT DOWNWARD AT SIB TOP (SNOW)'
        CUNIT  = 'W/M**2'
        CALL monit_regist_sib ( CMARK , CTITLE , CUNIT )
!
        CMARK = 'HSRUSTP' 
        CTITLE = 'RAD SHRT UPWARD   AT SIB TOP (SNOW)'
        CUNIT  = 'W/M**2'
        CALL monit_regist_sib ( CMARK , CTITLE , CUNIT )
!
      ENDIF 
!
      IF ( IMONIT_LEVEL .GE. IMONIT_ALMA ) THEN
        CMARK  = 'A_SWDN'           
        CTITLE = 'ALMA + Swnet and / Albedo (Shortwave down)'    
        CUNIT  = 'W/M**2'
        CALL monit_regist_sib ( CMARK , CTITLE , CUNIT )
!
        CMARK = 'A_SWUP'           
        CTITLE = 'ALMA - Swnet and * Albedo (Shortwave up)'    
        CUNIT  = 'W/M**2'
        CALL monit_regist_sib ( CMARK , CTITLE , CUNIT )
      ENDIF
!
      RETURN
      END