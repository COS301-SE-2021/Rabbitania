using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using backend_api.Models.User;

namespace backend_api.Models.Booking
{
    public class Booking 
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int BookingID { get; set; }
        
        public DateTime BookingDate { get; set; }
        public float Duration { get; set; }
        
        [ForeignKey("User")] 
        public int UserID { get; set; }
        
        public OfficeLocation OfficeLocation { get; set; } 
    }
}