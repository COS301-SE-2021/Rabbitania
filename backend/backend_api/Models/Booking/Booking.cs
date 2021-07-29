using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using backend_api.Models.User;

namespace backend_api.Models.Booking
{
    public class Booking : IBooking
    {
        public Booking(DateTime bookingDate, float duration, OfficeLocation officeLocation, int userId)
        {
            BookingDate = bookingDate;
            Duration = duration;
            OfficeLocation = officeLocation;
            UserId = userId;
        }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int BookingId { get; set; }
        
        public DateTime BookingDate { get; set; }
        
        public float Duration { get; set; }
        
        public OfficeLocation OfficeLocation { get; set; }
        
        public int UserId { get; set; }
        public Users User { get; set; }
        
    }
}