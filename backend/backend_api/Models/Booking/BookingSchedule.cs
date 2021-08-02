using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using backend_api.Models.User;

namespace backend_api.Models.Booking
{
    public class BookingSchedule: IBookingSchedule
    {
        public BookingSchedule()
        {
            
        }

        public BookingSchedule(DateTime timeSlot, OfficeLocation office, int availability)
        {
            TimeSlot = timeSlot;
            Office = office;
            Availability = availability;
        }
        
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public DateTime TimeSlot { get; set; }
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public OfficeLocation Office { get; set; }
        public int Availability { get; set; }
    }
}