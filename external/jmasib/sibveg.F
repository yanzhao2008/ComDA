! �� comveg 
! 99/06/xx �ۍ␪�G  ���̒�R�E�L���m�s�[��R�ϐ���ǉ�

       MODULE SIBVEG
!
!  SiB �֘A�́A�萔�B
!
!  �v���O���}�[�����̃R�����g�B
!     �e�錾���̌��̍s�́Ause ���p���p�B�������Ǝv���Ă悢�B
!

      USE SIBPRM, ONLY : 
     1   ITYP  ,        ! �A���^�C�v�� 81
     1   IMON  ,        ! ����         12
     1   ICG   ,        !               2   
     1   IWV   ,        !               3
     1   ILD   ,        ! ����          2
     1   IDP   ,        ! �y��w��      3
     1   IBD   ,        ! beam & diffuse 2  
     1   ITYO_veg,      ! 12       
     1   ITYO ,         ! 25 
     1   ITYP_veg       ! 40
!
      IMPLICIT NONE
!
      INTEGER,SAVE      :: IVEGFL         ! ���u�ԍ�
      LOGICAL,SAVE      :: LFIRST = .TRUE.
!
      INTEGER,PARAMETER :: ITYP_GLACIER = ITYP 
      INTEGER,PARAMETER :: ITYO_GLACIER = ITYO 
      REAL(8),PARAMETER :: XXX = 0.9
      REAL(8),PARAMETER :: XM1 = -1. 
!
!  ----------------------------------------------------
!  > �t�@�C������ǂݍ��ނ��� �i�����ɕς��Ȃ����́j< 
!  ----------------------------------------------------
!
!                      BAR : vcover ���悶���A�i�q���ϗʂ��Ӗ�����
!
! ���ˊ֘A
!
      REAL(8),SAVE :: TRAN_co(ITYP,ICG,IWV,ILD)=XXX ! TRAN 
      REAL(8)      :: TRAN   (ITYO,ICG,IWV,ILD)   ! ���ߓ��� 
      REAL(8),SAVE :: REF_co (ITYP,ICG,IWV,ILD)=XXX ! REF 
      REAL(8)      :: REF    (ITYO,ICG,IWV,ILD)   ! ���˓��� 
      REAL(8),SAVE :: RST_PAR_co(ITYP,ICG,3)=XXX  ! RSTPAR
      REAL(8)      :: RST_PAR   (ITYO,ICG,3)   ! RST��PAR�ˑ��萔
!                                              ! BAR  
      REAL(8),SAVE :: REF_SOIL_co (ITYP,IWV)=XXX ! SOREF
      REAL(8)      :: REF_SOIL    (ITYO,IWV)     ! ���n�A���x�h 
      REAL(8),SAVE :: CHI_L_co    (ITYP,ICG)=XXX ! XCHIL 
      REAL(8)      :: CHI_L       (ITYO,ICG)     ! ��L  
!
! ���U�֘A�萔
!
      REAL(8),SAVE :: F_RST_T_OPT_co (ITYP,ICG)=XXX ! TOPT
      REAL(8)      :: F_RST_T_OPT    (ITYO,ICG)     ! �œK���x  
      REAL(8),SAVE :: F_RST_T_MIN_co (ITYP,ICG)=XXX ! TLL
      REAL(8)      :: F_RST_T_MIN    (ITYO,ICG)     ! �Œ���E���x 
      REAL(8),SAVE :: F_RST_T_MAX_co (ITYP,ICG)=XXX ! TU
      REAL(8)      :: F_RST_T_MAX    (ITYO,ICG)     ! �ō����E���x 
      REAL(8),SAVE :: F_RST_DEFI_co  (ITYP,ICG)=XXX ! DEFAC 
      REAL(8)      :: F_RST_DEFI     (ITYO,ICG)     ! �O���ˑ����萔
      REAL(8),SAVE :: F_RST_POTLMAX_co(ITYP,ICG)=XXX! PH1  POT_LMAX 
      REAL(8)      :: F_RST_POTLMAX   (ITYO,ICG)    ! �t��Pot��� 
      REAL(8),SAVE :: F_RST_POTLMIN_co(ITYP,ICG)=XXX! PH2  POT_LMIN 
      REAL(8)      :: F_RST_POTLMIN   (ITYO,ICG)    ! �t��Pot���� 
!
! ���̒�R�֘A
!
      REAL(8),SAVE :: XLEN_ROOT_co (ITYP,ICG) =XXX  !     ROOTD 
      REAL(8)      :: XLEN_ROOT    (ITYO,ICG)       ! ���̒���  
      REAL(8),SAVE :: RLMAX_co     (ITYP,ICG) =XM1  ! �s�g�p  
      REAL(8)      :: RLMAX        (ITYO,ICG)       ! �s�g�p  
      REAL(8),SAVE :: ROOTCA_co    (ITYP,ICG) =XXX  ! ROOTCA 
      REAL(8)      :: ROOTCA       (ITYO,ICG)       ! ���f�ʐ�    
      REAL(8),SAVE :: R_PLANT_co   (ITYP,ICG) =XXX  ! RPLANT
      REAL(8)      :: R_PLANT      (ITYO,ICG)       ! �s�̒�R    
      REAL(8),SAVE :: RDRES_co     (ITYP,ICG) =XXX  ! RDRES
      REAL(8)      :: RDRES        (ITYO,ICG)       ! ���P�ʒ�����R 
!
! �y��̓���
!
      REAL(8),SAVE :: BEE_co       (ITYP)   =XXX  ! BEE   
      REAL(8)      :: BEE          (ITYO)         ! �y�됅���ˑ����W�� 
      REAL(8),SAVE :: POT_SAT_SOIL_co(ITYP) =XXX  ! PHSAT 
      REAL(8)      :: POT_SAT_SOIL   (ITYO)       ! �O�a���̓y��|�e���V���� 
      REAL(8),SAVE :: WCOEF_SAT_SOIL_co (ITYP)=XXX  ! SATCO 
      REAL(8)      :: WCOEF_SAT_SOIL    (ITYO)      ! �O�a�����W��  
      REAL(8),SAVE :: POR_SOIL_co    (ITYP)   =XXX  ! POROS
      REAL(8)      :: POR_SOIL       (ITYO)         ! �󌄗�   
      REAL(8),SAVE :: SINX_co        (ITYP)   =XXX  ! SLOPE  
      REAL(8)      :: SINX           (ITYO)         ! �y��w�̌X�� 
      REAL(8),SAVE :: DEP_SOIL_co    (ITYP,IDP)=XXX ! ZDEPTH
      REAL(8)      :: DEP_SOIL       (ITYO,IDP)     ! �y��w�̐[��    
!
!  ------------------------------------------------
!  > �t�@�C������ǂݍ��ނ��� �i�����ɕς����́j< 
!  ------------------------------------------------
!
! ���ˊ֘A
!
      REAL(8),SAVE :: GREEN_mo(ITYP,IMON,ICG) =XXX ! XGREEN
      REAL(8),SAVE :: GREEN   (ITYO,IMON,ICG)      ! �����Ă��銄�� 
!
! �A���֘A
!
      REAL(8),SAVE :: CVR_VEG_mo(ITYP,IMON,ICG)=XXX ! XCOVER -> VCOVER 
      REAL(8),SAVE :: CVR_VEG   (ITYO,IMON,ICG)     ! �핢�� 
      REAL(8),SAVE :: XLAI_mo   (ITYP,IMON,ICG)=XXX ! XZLT -> ZLT 
      REAL(8),SAVE :: XLAI      (ITYO,IMON,ICG)     ! LAI, �i�q����
      REAL(8),SAVE :: Z0_mo     (ITYP,IMON)    =XXX ! X0X
      REAL(8),SAVE :: Z0        (ITYO,IMON)         ! �e�x z0
      REAL(8),SAVE :: D_ZERO_mo (ITYP,IMON)    =XXX ! XD
      REAL(8),SAVE :: D_ZERO    (ITYO,IMON)         ! ��ʕψ� d 
      REAL(8),SAVE :: Z2_mo     (ITYP,IMON)    =XXX ! Z2
      REAL(8),SAVE :: Z2        (ITYO,IMON)         ! �L���m�s�[��[����
      REAL(8),SAVE :: Z1_mo     (ITYP,IMON)    =XXX ! Z1
      REAL(8),SAVE :: Z1        (ITYO,IMON)         ! �L���m�s�[���[����
      REAL(8),SAVE :: FAC_AG_mo (ITYP,IMON)    =XXX ! XDC -> RDC 
      REAL(8),SAVE :: FAC_AG    (ITYO,IMON)         ! R_AG �֘A�萔  
      REAL(8),SAVE :: FAC_AC_BAR_mo(ITYP,IMON) =XXX ! XBC -> RBC 
      REAL(8),SAVE :: FAC_AC_BAR   (ITYO,IMON)      ! R_AC �֘A�萔
!
! ���̒�R�֘A
!
      REAL(8),SAVE :: ROOTL_BAR_mo (ITYP,IMON,ICG) =XXX ! XROOTL -> ROOTL 
      REAL(8),SAVE :: ROOTL_BAR    (ITYO,IMON,ICG)      ! ���̖��x 
!
!  ---------------------------
!  > root_ini �Ōv�Z������� < 
!  ---------------------------
!
      REAL(8),SAVE :: DEP_RMEAN_co(ITYP,IDP,ICG) =XXX! �V�K
                                                     ! �w�������ϐ[��
      REAL(8),SAVE :: DEP_ROOT_co (ITYP,IDP,ICG) =XXX! �V�K
                                                     ! �w�����̒���
!
      REAL(8),SAVE :: ALPHAF_BAR_mo (ITYP,IMON,ICG)=XXX ! �V�K
                                                        ! ����R�֘A�W����
      REAL(8),SAVE :: BETAF_BAR_mo  (ITYP,IMON,ICG)=XXX ! �V�K
                                                        ! ����R�֘A�W����
!
!  -----------------------------
!  > canopy_ini �Ōv�Z������� < 
!  -----------------------------
!
      REAL(8),SAVE :: CVR_VEG_INV_mo(ITYP,IMON,ICG)=XXX ! XCOVER -> VCOVER 
!
      REAL(8),SAVE :: Z2_INV_mo     (ITYP,IMON)    =XXX! Z2
                                                       ! �L���m�s�[��[���� 
!
      REAL(8),SAVE :: FAC_AG_INV_mo (ITYP,IMON)    =XXX! XDC -> RDC 
                                                       ! R_AG �֘A�萔 
      REAL(8),SAVE :: FAC_AC_BAR_INV_mo(ITYP,IMON) =XXX! XBC -> RBC 
                                                       ! R_AC �֘A�萔 
!
!  -----------------------------
!  > soil_ini �Ōv�Z������� < 
!  -----------------------------

      REAL(8),SAVE :: DEP_SOIL_INV_co  (ITYP,IDP) =XXX ! ZDEPTH
                                                       ! �y��w�̐[�� 
      REAL(8),SAVE :: POR_SOIL_INV_co  (ITYP)   =XXX   ! POROS
                                                       ! �󌄗�   (ITYP)  
!
      CONTAINS 
!=============================================================
      SUBROUTINE SIBVEG_INI( IVEGFL )
!
#ifdef MPIRUN
      use com_parallel, only :
     &  IRANK
#endif
!
      USE SIBCON , ONLY :
     1    PIE_c,
     1    ALBEDO_ICESHEET_SOIL_VIS_c,
     1    ALBEDO_ICESHEET_SOIL_NIR_c
!
! SIBVEG �f�[�^�̓ǂݍ���
!
      IMPLICIT NONE 
!
      integer,intent(in) :: ivegfl
!
#ifdef MPIRUN
      INCLUDE 'mpif.h'
      integer :: ierr 
#endif
!
      INTEGER :: I
      INTEGER :: JCG
      INTEGER :: JTYP  
      INTEGER :: JMON
!
      ! �����ڂ��Ă���w�̏�[�̐[��
      REAL(8)   :: CURRENT_DEPTH 
      REAL(8)   :: VOL_ROOT_BAR                  ! ���̑̐� Vr 
!
      REAL(8), SAVE:: F0001 = 0.0001D0
      ! �e�w�Ɋ��蓖�Ă鍪�̒����̍ŏ��l�B�Ƃ肠�����[����������邽��
      ! 1cm �ɂ��Ă���
      REAL(8),SAVE :: ROOT_LENGTH_MIN = 1.0d-2
! 
! ------------
! > �ǂݍ��� <
! ------------
! 
      IF ( LFIRST ) THEN
        WRITE(6,*) 'sibveg_ini_fileread 99/07/21 pochaka X'
        LFIRST = .FALSE. 
      ELSE 
        WRITE(6,*) 'sibveg_ini_fileread should be called already. X '
        STOP 999
      ENDIF
!
#ifdef MPIRUN
      if ( IRANK .eq. 0 ) then
#endif

      READ(IVEGFL) 
     1 TRAN       , REF          , RST_PAR      , REF_SOIL  , 
     1 CHI_L      , F_RST_T_OPT  , F_RST_T_MIN  , F_RST_T_MAX , 
     1 F_RST_DEFI , F_RST_POTLMAX, F_RST_POTLMIN, XLEN_ROOT   , 
     1 RLMAX      , ROOTCA       , R_PLANT      , RDRES       , 
     1 BEE        , POT_SAT_SOIL , WCOEF_SAT_SOIL,POR_SOIL    , 
     1 SINX       , DEP_SOIL
!
      READ(IVEGFL) 
     1 GREEN      , CVR_VEG      , XLAI        , Z0           , 
     1 D_ZERO     , Z2           , Z1          , FAC_AG       , 
     1 FAC_AC_BAR , ROOTL_BAR
!
      REWIND IVEGFL
!
!----  �X���̓y��̃A���x�h�̏C��
! �C��l�t�@�C���̕X���̗��n�A���x�h�͏���������(VIS0.1, NIR 0.15)
! sincon�Œ�`�����l�ɒu������
!
       REF_SOIL(25,1)=ALBEDO_ICESHEET_SOIL_VIS_c
       REF_SOIL(25,2)=ALBEDO_ICESHEET_SOIL_NIR_c
       write(6,*) 'sibveg: Icesheet ground albedo are modified to: ', 
     1            'VIS : ', REF_SOIL(25,1) ,
     1            'NIR : ', REF_SOIL(25,2)
!
#ifdef MPIRUN
      endif
!
      CALL MPI_BCAST(TRAN, ITYO*ICG*IWV*ILD, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(REF, ITYO*ICG*IWV*ILD, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(RST_PAR, ITYO*ICG*IWV, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(REF_SOIL, ITYO*IWV, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(CHI_L, ITYO*ICG, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(F_RST_T_OPT, ITYO*ICG, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(F_RST_T_MIN, ITYO*ICG, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(F_RST_T_MAX, ITYO*ICG, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(F_RST_DEFI, ITYO*ICG, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(F_RST_POTLMAX, ITYO*ICG, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(F_RST_POTLMIN, ITYO*ICG, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(XLEN_ROOT, ITYO*ICG, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(RLMAX, ITYO*ICG, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(ROOTCA, ITYO*ICG, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(R_PLANT, ITYO*ICG, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(RDRES, ITYO*ICG, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(BEE, ITYO, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(POT_SAT_SOIL, ITYO, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(WCOEF_SAT_SOIL, ITYO, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(POR_SOIL, ITYO, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(SINX, ITYO, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(DEP_SOIL, ITYO*IDP, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
!
      CALL MPI_BCAST(GREEN, ITYO*IMON*ICG, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(CVR_VEG, ITYO*IMON*ICG, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(XLAI, ITYO*IMON*ICG, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(Z0, ITYO*IMON, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(D_ZERO, ITYO*IMON, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(Z2, ITYO*IMON, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(Z1, ITYO*IMON, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(FAC_AG, ITYO*IMON, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(FAC_AC_BAR, ITYO*IMON, MPI_DOUBLE_PRECISION,
     1               0, MPI_COMM_WORLD, IERR)
      CALL MPI_BCAST(ROOTL_BAR, ITYO*IMON*ICG, MPI_DOUBLE_PRECISION,       
     1               0, MPI_COMM_WORLD, IERR)
      
#endif
!
! --------
! > �쐬 <
! --------
!
!  1-12 �� 25 �̓R�s�[
!
      do i = 1, ityo_veg 
        call sibveg_copy_veg ( i          , i          )        ! �k����
      enddo
      call sibveg_copy_veg   ( ityo_glacier , ityp_glacier )    ! �X��
!
!  21 �� 12(�k��n)�����Ƃɍ쐬 ( 12 �� 7 �� �� 14 �� 8���� )
      call sibveg_copy_veg ( 12 , 21  )        
      call sibveg_veg_mod  ( 12 , 21 , 7 ,  8 )        
      call sibveg_veg_mod  ( 12 , 21 , 8 ,  9 )        
      call sibveg_veg_mod  ( 12 , 21 , 9 , 10 )        
      call sibveg_veg_mod  ( 12 , 21 , 9 , 11 )        
      call sibveg_veg_mod  ( 12 , 21 , 9 , 12 )        
      call sibveg_veg_mod  ( 12 , 21 , 3 ,  1 )        
      call sibveg_veg_mod  ( 12 , 21 , 3 ,  2 )        
!
      write(6,*) 'sibveg__ini_fileread 12 lai c ' , xlai_mo(12,:,1)
      write(6,*) 'sibveg__ini_fileread 21 lai c ' , xlai_mo(21,:,1)
      write(6,*) 'sibveg__ini_fileread rlmaxo  c ' , rlmax  (:,1)  
      write(6,*) 'sibveg__ini_fileread rlmaxa  c ' , rlmax_co(:,1)  
!
! ------------
! > �l�̕␳ <
! ------------
!
      DO 1000 JCG  =1,ICG
      DO 1000 JMON =1,IMON
      DO 1000 JTYP =1,ITYP
        if ( green_mo(jtyp,jmon,jcg) .lt. f0001 ) then
          write(6,*) 'sibveg_ini green modified jtyp/jmon/jcg' ,
     1               jtyp , jmon , jcg , 
     1               green_mo(jtyp,jmon,jcg) , ' to ' , f0001
        endif   
        GREEN_mo (JTYP,JMON,JCG)=MAX(F0001,GREEN_mo(JTYP,JMON,JCG))
 1000 CONTINUE
!
      DO 1100 JCG  =1,ICG
      DO 1100 JTYP =1,ITYP
!        CHI_L_co(JTYP,JCG) = MAX ( CHI_L_co(JTYP,JCG) , 0.01D0 )  ! bug
        IF ( ABS( CHI_L_co(JTYP,JCG) ) .LE. 0.01 ) THEN
           write(6,*) 'sibveg_ini chi_l modified JCG/JTYP=', JCG, JTYP,
     1                 CHI_L_co(JTYP,JCG) , ' to ' , 0.01 
           CHI_L_co(JTYP,JCG) = 0.01D0 
        ENDIF
 1100 CONTINUE
!
! ------------------------------
! > �L���m�s�[�ʂ̋t���Ȃǌv�Z <
! ------------------------------
! 
      DO JCG =1,ICG
      DO JMON=1,IMON
      DO JTYP=1,ITYP
#ifdef SIB_DEBUG
        if (       CVR_VEG_mo (JTYP,JMON,JCG) .lt. 1.D-30 ) THEN
           write(6,*)  CVR_VEG_mo (JTYP,JMON,JCG)    
           stop 998
        endif
#endif
        CVR_VEG_INV_mo (JTYP,JMON,JCG) = 1./ CVR_VEG_mo (JTYP,JMON,JCG)       
      ENDDO
      ENDDO
      ENDDO
!
      DO JMON=1,IMON
      DO JTYP=1,ITYP
#ifdef SIB_DEBUG
        if (       Z2_mo (JTYP,JMON)  .lt. 1.D-20 ) THEN
           write(6,*)  Z2_mo (JTYP,JMON)       
           stop 997
        endif
        if ( FAC_AG_mo (JTYP,JMON)   .lt. 1.D-20 ) then
           write(6,*)  jtyp, jmon, FAC_AG_mo (JTYP,JMON)       
           stop 996
        endif
        if ( FAC_AC_BAR_mo (JTYP,JMON)   .lt. 1.D-20 ) then
           write(6,*)  jtyp , jmon , FAC_AC_BAR_mo (JTYP,JMON)       
           stop 995
       endif
#endif
        Z2_INV_mo         (JTYP,JMON) = 1./ Z2_mo (JTYP,JMON)       
        FAC_AG_INV_mo     (JTYP,JMON) = 1./ FAC_AG_mo (JTYP,JMON)       
        FAC_AC_BAR_INV_mo (JTYP,JMON) 
     1        = 1./ FAC_AC_BAR_mo (JTYP,JMON)       
      ENDDO
      ENDDO
!
! ----------------------
! > �y��֘A�̕����ݒ� <
! ----------------------
!
      DO I=1,ITYP
        DEP_SOIL_INV_co (I,1) = 1 / DEP_SOIL_co(I,1)
        DEP_SOIL_INV_co (I,2) = 1 / DEP_SOIL_co(I,2)
        DEP_SOIL_INV_co (I,3) = 1 / DEP_SOIL_co(I,3)
        POR_SOIL_INV_co (I)   = 1 / POR_SOIL_co(I)
      ENDDO
!
! --------------------------
! > ���̒�R�֘A�̕����ݒ� <
! --------------------------
!
      DO, JCG = 1, ICG
        DO, I = 1, ITYP
          !
          ! ��1�w
          !
          DEP_ROOT_co(I, 1, JCG) 
     1      = MAX(ROOT_LENGTH_MIN, 
     2        MIN(DEP_SOIL_co(I, 1),
     3        XLEN_ROOT_co(I, JCG)))
          DEP_RMEAN_co(I, 1, JCG) = DEP_ROOT_co(I, 1, JCG) * 0.5D0
          !
          ! ��2�w
          !
          CURRENT_DEPTH = DEP_SOIL_co(I, 1)
          DEP_ROOT_co(I, 2, JCG) 
     1      = MAX(ROOT_LENGTH_MIN,
     2        MIN(DEP_SOIL_co(I, 2),
     3        (XLEN_ROOT_co(I, JCG) - CURRENT_DEPTH)))
          DEP_RMEAN_co(I, 2, JCG) = DEP_ROOT_co(I, 2, JCG) * 0.5D0
          !
          ! ��3�w
          !
          CURRENT_DEPTH = CURRENT_DEPTH + DEP_SOIL_co(I, 2)
          DEP_ROOT_co(I, 3, JCG) 
     1      = MAX(ROOT_LENGTH_MIN, 
     2        MIN(DEP_SOIL_co(I, 3),
     3        (XLEN_ROOT_co(I, JCG) - CURRENT_DEPTH)))
          DEP_RMEAN_co(I, 3, JCG) = DEP_ROOT_co(I, 3, JCG) * 0.5D0
        END DO
      END DO
!
! ���̒�R�̕����萔
!
      DO JMON =1,IMON
      DO JCG=1,ICG
      DO I   =1,ITYP
        VOL_ROOT_BAR = ROOTL_BAR_mo(I,JMON,JCG) * ROOTCA_co(I,JCG)
!                                                           ! Vr ���xm^3/m^3
!
        ALPHAF_BAR_mo(I,JMON,JCG)                              ! ��
     1      = 1.0D0 / ( 8.0D0 * PIE_c * ROOTL_BAR_mo(I,JMON,JCG) )
     1              * ( VOL_ROOT_BAR 
     1                  - 3.0D0
     1                  - 2.0D0 / (1.0D0 - VOL_ROOT_BAR )
     1                          * LOG(VOL_ROOT_BAR) )
!
        BETAF_BAR_mo(I,JMON,JCG) 
     1      = RDRES_co(I,JCG) / ROOTL_BAR_mo(I,JMON,JCG)
      ENDDO 
      ENDDO
      ENDDO
!
      write(6,*) 'end sibveg__ini_fileread'
!
      RETURN
      END SUBROUTINE SIBVEG_INI
!================================================================
      SUBROUTINE SIBVEG_COPY_VEG ( I1_IN , I2_IN ) 
!
      integer,intent(in) :: I1_IN, I2_IN
      integer            :: I1   , I2 
!
      integer :: ii
      integer :: ii_end
!
      write(6,*) 'sibveg_copy_veg ' , 
     1           'original typ ' , i1_in , ' is copied to ' , i2_in  
!
      ii_end = 2 
      if ( i1_in .eq. ityo_glacier ) ii_end = 1
    
      do ii=1,ii_end
        i1 = i1_in + (ii-1)*ityo_veg 
        i2 = i2_in + (ii-1)*ityp_veg 
!
        TRAN_co     (I2,:,:,:) = TRAN     (I1,:,:,:) 
        REF_co      (I2,:,:,:) = REF      (I1,:,:,:) 
        RST_PAR_co  (I2,:,:  ) = RST_PAR  (I1,:,:  ) 
        REF_SOIL_co (I2,:    ) = REF_SOIL (I1,:    )
        CHI_L_co    (I2,:    ) = CHI_L    (I1,:    )
!
        F_RST_T_OPT_co   (I2,:)  = F_RST_T_OPT   (I1,:)
        F_RST_T_MIN_co   (I2,:)  = F_RST_T_MIN   (I1,:)
        F_RST_T_MAX_co   (I2,:)  = F_RST_T_MAX   (I1,:)
        F_RST_DEFI_co    (I2,:)  = F_RST_DEFI    (I1,:)
        F_RST_POTLMAX_co (I2,:)  = F_RST_POTLMAX (I1,:)
        F_RST_POTLMIN_co (I2,:)  = F_RST_POTLMIN (I1,:)
!
        XLEN_ROOT_co     (I2,:)  = XLEN_ROOT     (I1,:)
        RLMAX_co         (I2,:)  = RLMAX         (I1,:)
        ROOTCA_co        (I2,:)  = ROOTCA        (I1,:)
        R_PLANT_co       (I2,:)  = R_PLANT       (I1,:)
        RDRES_co         (I2,:)  = RDRES         (I1,:)
!
        BEE_co            (I2)    = BEE            (I1)
        POT_SAT_SOIL_co   (I2)    = POT_SAT_SOIL   (I1)
        WCOEF_SAT_SOIL_co (I2)    = WCOEF_SAT_SOIL (I1)
        POR_SOIL_co       (I2)    = POR_SOIL       (I1)
        SINX_co           (I2)    = SINX           (I1)
        DEP_SOIL_co       (I2,:)  = DEP_SOIL       (I1,:)
!
        GREEN_mo    (I2,:,:) = GREEN    (I1,:,:)
!
        CVR_VEG_mo  (I2,:,:) = CVR_VEG  (I1,:,:)
        XLAI_mo     (I2,:,:) = XLAI     (I1,:,:)
        Z0_mo       (I2,:  ) = Z0       (I1,:  )
        D_ZERO_mo   (I2,:  ) = D_ZERO   (I1,:  )
        Z2_mo       (I2,:  ) = Z2       (I1,:  )
        Z1_mo       (I2,:  ) = Z1       (I1,:  )
        FAC_AG_mo   (I2,:  ) = FAC_AG   (I1,:  )       
        FAC_AC_BAR_mo(I2,: ) = FAC_AC_BAR (I1,:)
!
        ROOTL_BAR_mo (I2,:,:) = ROOTL_BAR (I1,:,:)
!
      enddo 
      END SUBROUTINE SIBVEG_COPY_VEG   
! ===============================================================
      SUBROUTINE SIBVEG_VEG_MOD ( I1_IN , I2_IN , I1M_IN , I2M_IN  ) 
!
      implicit none
!
      integer,intent(in) :: I1_IN , I2_IN
      integer,intent(in) :: I1M_IN, I2M_IN 
      integer            :: I1   , I2 
      integer            :: I1M  , I2M 
!
      integer            :: ii
!
      if (      i1_in .eq. ityo_glacier 
     1     .or. i1_in .gt. ityo_veg
     1     .or. i2_in .gt. ityp_veg
     1     .or. i1m_in .lt. 1 
     1     .or. i2m_in .lt. 1 
     1     .or. i1m_in .gt. 12
     1     .or. i2m_in .gt. 12 
     1   ) then
        write(6,*) 'sibveg_veg_mod error'
        stop 999
      endif
!
      write(6,*) ' sibveg_veg_mod : ' , 
     1           ' typ= ' , i1_in , ' m= ' , i1m_in , 
     1           ' is copied to typ= ' , i2_in , ' m= ' , i2m_in   
!
      write(6,*) 'are'
!    
      do ii=1,2
        i1 = i1_in + (ii-1)*ityo_veg 
        i2 = i2_in + (ii-1)*ityp_veg 
!
        i1m = mod ( i1m_in + 6*(ii-1) - 1 , 12 ) + 1
        i2m = mod ( i2m_in + 6*(ii-1) - 1 , 12 ) + 1
!
        GREEN_mo     (I2,I2M,:) = GREEN      (I1,I1M,:)
!
        CVR_VEG_mo   (I2,I2M,:) = CVR_VEG    (I1,I1M,:)
        XLAI_mo      (I2,I2M,:) = XLAI       (I1,I1M,:)
        Z0_mo        (I2,I2M  ) = Z0         (I1,I1M  )
        D_ZERO_mo    (I2,I2M  ) = D_ZERO     (I1,I1M  )
        Z2_mo        (I2,I2M  ) = Z2         (I1,I1M  )
        Z1_mo        (I2,I2M  ) = Z1         (I1,I1M  )
        FAC_AG_mo    (I2,I2M  ) = FAC_AG     (I1,I1M  )       
        FAC_AC_BAR_mo(I2,I2M  ) = FAC_AC_BAR (I1,I1M  )
!
        ROOTL_BAR_mo (I2,I2M,:) = ROOTL_BAR  (I1,I1M,:)
!
        write(6,*) 'ii=' , ii ,'end'
      enddo
! 
      END SUBROUTINE SIBVEG_VEG_MOD   
!================================================================
      END MODULE SIBVEG