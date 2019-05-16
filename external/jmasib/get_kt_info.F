      SUBROUTINE GET_KTINFO (
     I    IDSTAR , 
     O    IDATE  , KTP    , KT0    , FSECP ) 
!
      USE COM_JOBINFO_SIB0109 , ONLY : 
     1    IUNIT_RESTART_IN   
!
      USE CALENDAR , ONLY : CALENDAR_RUN_GETID
!
      IMPLICIT NONE
!
      INTEGER,INTENT(IN)     :: IDSTAR(5) 
!
      INTEGER,INTENT(OUT)    :: IDATE (5) 
      INTEGER,INTENT(OUT)    :: KTP 
      INTEGER,INTENT(OUT)    :: KT0 
      REAL(8),INTENT(OUT)    :: FSECP
!
      INTEGER                :: MKTP
!
!  �ϕ������������ƂɁAIDATE �� KT ����ݒ肷��B
!  ���̂����́A�{���̓C���`�L�����A�d���Ȃ��B
!
!
      IF       ( IUNIT_RESTART_IN .LE. 0 ) THEN   ! �����l�ϕ� 
        KT0      = -1 
        KTP      =  0 
        IDATE(:) = IDSTAR(:)
        FSECP    = 0. 
        
      ELSE IF  ( IUNIT_RESTART_IN .GT. 0 ) THEN   
        KT0      = 23 
        KTP      = 24 
        MKTP     = -KTP       
        CALL CALENDAR_RUN_GETID ( IDSTAR , IDATE , MKTP ) 
!
        FSECP    = 86400.D0 
!
      ENDIF
!
      RETURN
      END SUBROUTINE