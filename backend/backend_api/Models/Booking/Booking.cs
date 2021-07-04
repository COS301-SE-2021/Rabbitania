using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using backend_api.Models.User;

namespace backend_api.Models.Booking
{
    public class Booking : IBooking
    {

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int BookingId { get; set; }
        
        public DateTime BookingDate { get; set; }
        
        public float Duration { get; set; }
        
        public OfficeLocation OfficeLocation { get; set; }
        
        [ForeignKey("User")] 
        public int UserId { get; set; }
        
    }
}