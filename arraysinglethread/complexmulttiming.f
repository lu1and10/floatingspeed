c     gfortran complexmulttiming.f -o complexmulttimingf -O3
c     ./complexmulttimingf
c
c     Note that 4*m doubles are needed for RAM, ie 32*m bytes.
c     Barnett 1/18/17, updated write * format 2/21/20
      program complexmulttiming
      implicit none
      integer m,i
      real *8, allocatable :: x(:),x2(:)
      complex*16, allocatable :: z(:),z2(:)
      complex*16 ima
c     or single-prec tests...  (<5% difference in speed)
c      real *4, allocatable :: x(:),x2(:)
c      complex*8, allocatable :: z(:),z2(:)
c      complex*8 ima
      real :: t0,t1
      data ima/(0.0d0,1.0d0)/
      m=1e8

c     real
      allocate(x(m))
      allocate(x2(m))
      do i=1,m
         x(i) = rand()
         x2(i) = rand()
      enddo
      call cpu_time(t0)
      do i=2,m
         x(i) = x(i-1) + x(i) * x2(i)
      enddo
      call cpu_time(t1)
      write (*,'(I10," fortran real*8 mults in ",f6.3," s")') m, t1-t0
      deallocate(x)
      deallocate(x2)

c     complex
      allocate(z(m))
      allocate(z2(m))
      do i=1,m
         z(i) = rand() + ima*rand()
         z2(i) = rand() + ima*rand()
      enddo
      call cpu_time(t0)
      do i=2,m
         z(i) = z(i-1) + z(i) * z2(i)
      enddo
      call cpu_time(t1)
      write (*,'(I10," fortran complex*16 mults in ",f6.3," s")') m,
     c     t1-t0

      end program
