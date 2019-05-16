! ����-> SiB �֘A���C���v���O����
! 99/07/xx �ۍ␪�G
! 99/08/04 �ۍ␪�G ��򂳂�ɓn���o�[�W�����t�B�b�N�X
! 99/08/30 �ۍ␪�G �R�����g���ύX�B
!
!
      SUBROUTINE RAD2SIB_SUM_MAIN ( 
     I   NMAX        , NMAX_01        , 
#ifdef MONYOS
     I   DELT_CNP    ,
#endif
     I   NTYP        , MON            , 
     I   CVR_VEG_ms  , CVR_VEG_INV_ms ,   ZLT_NOS , ZLT_SNW , 
     I   ZMEAN       , ZTEMP          , 
     I   TMP_GRSK    , TMP_SNSK       , 
     I   TMP_CNP_NOS , TMP_CNP_SNW    , 
     I   RAD_LONG_INTO_SIB  , 
     M   RAD_SHRT_NOS , RAD_SHRT_SNW  , 
     O   RAD_SHRT_INTO_SNOW_LAYER     , 
     O   THERMK_NOS    ,  
     O   THERMK_SNW    , 
     O   RAD_LONG_NOS_2_ATM , RAD_LONG_SNW_2_ATM ,     
     O   RAD_LONG_NOS , RAD_LONG_SNW )   
!
      USE SIBPRM , ONLY : 
     1    IDX   , 
     1    ICG    
!
      IMPLICIT NONE
!
! INPUT  
!
      REAL(8),INTENT(IN) ::
     1  CVR_VEG_ms     ( IDX,ICG ) ,        ! ���ˁA���B��
     1  CVR_VEG_INV_ms ( IDX,ICG )          ! ���ˁA���B��
!
      REAL(8),INTENT(IN) ::
     1  ZMEAN  (IDX)               , 
     1  ZTEMP  (IDX) 

      REAL(8),INTENT(IN) ::
     1  ZLT_NOS  (IDX,ICG) ,
     1  ZLT_SNW  (IDX,ICG)

!
      REAL(8),INTENT(IN)  ::
     1  TMP_CNP_NOS(IDX) , 
     1  TMP_CNP_SNW(IDX) , 
     1  TMP_GRSK   (IDX) , 
     1  TMP_SNSK   (IDX)  
!
      INTEGER,INTENT(IN)  ::  NTYP     (IDX)   

!
      INTEGER,INTENT(IN)   :: MON 
      INTEGER,INTENT(IN)   :: NMAX
      INTEGER,INTENT(IN)   :: NMAX_01(3)
!
#ifdef MONYOS
      REAL(8),INTENT(IN)   :: DELT_CNP
#endif
!
! INPUT 
!
      REAL(8),INTENT(INOUT) ::  RAD_SHRT_NOS  (IDX,ICG)         
      REAL(8),INTENT(INOUT) ::  RAD_SHRT_SNW  (IDX,ICG)             
!
! OUTPUT 
!
!   CG �A��ł̒P�ʎ��Ԃ�������ˋz���� �i�z�������j
!
      REAL(8),INTENT(OUT)  :: 
     1    RAD_SHRT_INTO_SNOW_LAYER (IDX)       ! ��w�̕��ˋz����
!    1    RAD_SUM_SNW       (IDX,ICG)        , ! CG �ł̕��ˋz���� 
!    1    RAD_SUM_NOS       (IDX,ICG)        
!
      REAL(8),INTENT(OUT)  :: 
     1    RAD_LONG_NOS      (IDX,ICG)        ,
     1    RAD_LONG_SNW      (IDX,ICG)
!
      REAL(8),INTENT(OUT)  :: 
     1    RAD_LONG_NOS_2_ATM      (IDX) 
      REAL(8),INTENT(OUT)  :: 
     1    RAD_LONG_SNW_2_ATM      (IDX)
!
!
!   �L���m�s�[�ł�  1-�ˏo��
!
      REAL(8),INTENT(OUT)   :: THERMK_SNW  (IDX)       ! 1 - �L���m�s�[�ˏo��
      REAL(8),INTENT(OUT)   :: THERMK_NOS  (IDX)       ! 1 - �L���m�s�[�ˏo��
!
      REAL(8),INTENT(IN)    :: RAD_LONG_INTO_SIB (IDX) 
!
      REAL(8)     :: DUMMY_IDX(IDX)
!
      LOGICAL LFIRST
      DATA LFIRST /.TRUE./
!
      IF ( LFIRST ) THEN
        WRITE(6,*) 'RAD2SIB_SUM_MAIN 00/07 POCHAKA ' , MON 
        LFIRST = .FALSE.
      ENDIF 
!
! ==================
! >> �Z�g���˕␳ <<
! ==================
!  �ꎞ�ԕ��ς̓V���p���狁�߂��t���b�N�X�ɁA
!  �e�X�e�b�v�ł̓V���p��^���邱�Ƃŕ␳����B
!
      CALL RAD_SHRT_COR (
     I  NMAX    , NMAX_01 , 
     I  ZMEAN   , ZTEMP   , 
     M  RAD_SHRT_NOS      ,  RAD_SHRT_SNW       )  
!
! ========================
! >> ���˂̊e�����̉��Z <<
! ========================
!
!    �Z�g�ƒ��g�������āA�L���m�s�[�E�n�ʂ��󂯎��G�l���M�[�̘a�����߂�B
!    ���g�ɂ��ẮA�L���m�s�[�ł̎ˏo���i�z�����j���v�Z����B
!
!    ���ӁB
!      �E��w�ɓ���ARAD_SHRT_SNW(*,2) �ɂ��Ă� RAD_SUM_SNW �ɉ��Z���Ȃ��B
!        ������ RAD_SHRT_intoSNW �Ɋi�[����B
!      �E���g�ɂ��Ă͂����� RAD �i�q���� SiB �i�q�ɕϊ�����B
!
      CALL RAD_SUM_ALL (
     I  1              , NMAX_01(3)     , 0          ,  
#ifdef MONYOS
     I  DELT_CNP   , 
#endif 
     I  NTYP           , 
     I  TMP_CNP_NOS    , TMP_GRSK       ,  
     I  CVR_VEG_ms     , CVR_VEG_INV_ms , 
     I  RAD_LONG_INTO_SIB               , ZLT_NOS , 
     I  RAD_SHRT_NOS   , 
     O  THERMK_NOS     , 
     O  DUMMY_IDX      , 
     O  RAD_LONG_NOS_2_ATM , 
     O  RAD_LONG_NOS )
!
      CALL RAD_SUM_ALL (
     I  NMAX_01(2)     , NMAX           , 1          ,  
#ifdef MONYOS
     I  DELT_CNP   , 
#endif 
     I  NTYP           , 
     I  TMP_CNP_SNW    , TMP_SNSK       ,  
     I  CVR_VEG_ms     , CVR_VEG_INV_ms , 
     I  RAD_LONG_INTO_SIB               , ZLT_SNW , 
     M  RAD_SHRT_SNW   , 
     O  THERMK_SNW     , 
     O  RAD_SHRT_INTO_SNOW_LAYER        , 
     O  RAD_LONG_SNW_2_ATM ,  
     O  RAD_LONG_SNW  )
!
      RETURN
      END
!=======================================================
      SUBROUTINE RAD2SIB_EXTEND (
     I   NMAX      , 
     I   NTYP      , MON        ) 
!
! �W�J����
!
      USE SIBPRM , ONLY :
     1   IDX    ,
     1   ITYP   , 
     1   ICG  
!
      USE SIBVEG , ONLY :
     1           CVR_VEG_mo                ! �핢�� (ITYP,IMON,ICG)
!
      IMPLICIT NONE
!
      INTEGER,INTENT(IN)   :: NMAX         ! ���i�q��
      INTEGER,INTENT(IN)   :: NTYP (IDX)  ! �A���^�C�v
      INTEGER,INTENT(IN)   :: MON          ! ��
!
! WORK  
!
      INTEGER :: I
      INTEGER :: IVEG
!
      LOGICAl,SAVE :: LFIRST 
!
      DATA LFIRST /.TRUE. /
!
      IF ( LFIRST ) THEN
        WRITE(6,*) 'RAD2SIB EXTEND 99/07 POCHAKA ' 
     1             , ' DUMMY ' , NMAX , MON , NTYP 
        LFIRST = .FALSE. 
      ELSE
        WRITE(6,*) 'RAD2SIB EXTEND HAS ALREADY CALLED'
        STOP 999
      ENDIF
!
      DO 1000 IVEG=1,ICG
      DO 1000 I=1,NMAX
!       CVR_VEG_ms    (I,IVEG) = CVR_VEG_mo(NTYP(I),MON,IVEG)
!       CVR_VEG_INV_ms(I,IVEG) = 1/CVR_VEG_mo(NTYP(I),MON,IVEG)
 1000 CONTINUE
!
      RETURN
      END