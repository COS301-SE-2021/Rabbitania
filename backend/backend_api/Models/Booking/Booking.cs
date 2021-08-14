using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using backend_api.Models.Enumerations;
using backend_api.Models.User;

namespace backend_api.Models.Booking
{
    public class Booking : IBooking
    {
        public Booking(string bookingDate, string timeSlot, OfficeLocation office, int userId)
        {
            BookingDate = bookingDate;
            TimeSlot = timeSlot;
            Office = office;
            UserId = userId;
        }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int BookingId { get; set; }
        public string BookingDate { get; set; }
        
        [ForeignKey("BookingSchedules")]
        public string TimeSlot { get; set; }
        
        [ForeignKey("BookingSchedules")]
        public OfficeLocation Office { get; set; }
        
        public int UserId { get; set; }
        public Users User { get; set; }
        
    }
}