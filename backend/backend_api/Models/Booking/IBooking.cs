using System;
using System.ComponentModel.DataAnnotations.Schema;
using backend_api.Models.User;

namespace backend_api.Models.Booking
{
    public interface IBooking
    {
         int BookingId { get; set; }
        
         DateTime BookingDate { get; set; }
         
         float Duration { get; set; }
        
         OfficeLocation OfficeLocation { get; set; }
         
         int UserId { get; set; }
         
    }
}