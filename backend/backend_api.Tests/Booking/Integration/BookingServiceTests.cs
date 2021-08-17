using System.Collections.Generic;
using System.Linq;
using System.Net;
using backend_api.Data.Booking;
using backend_api.Data.User;
using backend_api.Exceptions.Booking;
using backend_api.Models.Auth.Requests;
using backend_api.Models.Booking.Requests;
using backend_api.Models.Booking.Responses;
using backend_api.Models.Enumerations;
using backend_api.Models.User;
using backend_api.Services.Auth;
using backend_api.Services.Booking;
using FluentAssertions;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Xunit;

namespace backend_api.Tests.Booking.Integration
{
    public class BookingServiceTests
    {
        private readonly Models.Booking.Booking _mockBooking;
        private readonly BookingContext _bookingContext;
        private readonly BookingScheduleContext _bookingSchedule;
        public BookingServiceTests()
        {
            var serviceProvider = new ServiceCollection().AddEntityFrameworkNpgsql().BuildServiceProvider();
            var builder = new DbContextOptionsBuilder<BookingContext>();
            var builder1 = new DbContextOptionsBuilder<BookingScheduleContext>();
            
            builder.UseNpgsql("Server=localhost;Port=5432;Database=RabbitaniaTesting;Username=postgres;Password=1234")
                .UseInternalServiceProvider(serviceProvider);
            
            _bookingContext = new BookingContext(builder.Options);
            _bookingSchedule = new BookingScheduleContext(builder1.Options);
            
             this._mockBooking = new Models.Booking.Booking(
                "2021-08-17 19:58",
                "Monday,Morning",
                0,
                1
            );
        }
        
        [Fact(DisplayName = "Should return created status code if a new booking is created with correct details")]
        public async void ShouldCreateANewBooking()
        {
            //Arrange
            var bookingRepository = new BookingRepository(_bookingContext);
            var bookingScheduleRepo = new BookingScheduleRepository(_bookingSchedule);
            var bookingScheduleServ = new BookingScheduleService(bookingScheduleRepo);
            
            var bookingService = new BookingService(bookingRepository, bookingScheduleRepo, bookingScheduleServ);

            var requestDto = new CreateBookingRequest
            {
                BookingDate = _mockBooking.BookingDate,
                TimeSlot = _mockBooking.TimeSlot,
                Office = _mockBooking.Office,
                UserId = _mockBooking.UserId
            };

            //Act
            var actualResponse = await bookingRepository.CreateBooking(requestDto);

            //Assert
            actualResponse.Should().Be(HttpStatusCode.Created);
        }

        [Fact(DisplayName = "Should return a bad request if details are not correct")]
        public async void ShouldNotCreateANewBooking()
        {
            //Arrange
            var bookingRepository = new BookingRepository(_bookingContext);
            var bookingScheduleRepo = new BookingScheduleRepository(_bookingSchedule);
            var bookingScheduleServ = new BookingScheduleService(bookingScheduleRepo);
            
            var bookingService = new BookingService(bookingRepository);

            var requestDto = new CreateBookingRequest
            {
                BookingDate = "",
                TimeSlot = "",
                Office = 0,
                UserId = -1
            };

            //Act
            var actualResponse = await bookingRepository.CreateBooking(requestDto);

            //Assert
            actualResponse.Should().Be(HttpStatusCode.BadRequest);
        }
        
        [Fact(DisplayName = "Should return all bookings that have been created")]
        public async void ShouldReturnAllBookingsCurrently()
        {
            //Arrange
            var bookingRepository = new BookingRepository(_bookingContext);
            var bookingService = new BookingService(bookingRepository);
            
            var requestDto = new GetAllBookingsRequest()
            {
                UserId = 1
            };
            var expected = await bookingRepository.GetAllBookings(requestDto);
            
            //Act
            var actualResponse = await bookingService.ViewAllBookings(requestDto);

            //Assert
            var @equals = actualResponse.Bookings.Equals(expected);
        }
        
        [Fact(DisplayName = "Should not return all bookings that have been created")]
        public async void ShouldNotReturnAllBookingsCurrently()
        {
            //Arrange
            var bookingRepository = new BookingRepository(_bookingContext);
            var bookingService = new BookingService(bookingRepository);
            
            var requestDto = new GetAllBookingsRequest()
            {
                UserId = 0
            };
            var expected = await bookingRepository.GetAllBookings(requestDto);
            
            //Act
            var actualResponse = await bookingService.ViewAllBookings(requestDto);
            
            //Assert
            var error = Assert.ThrowsAsync<InvalidBookingException>(() => bookingService.ViewAllBookings(requestDto));
            Assert.Equal("Authentication Failed", error.Result.Message);
        }
    }
}