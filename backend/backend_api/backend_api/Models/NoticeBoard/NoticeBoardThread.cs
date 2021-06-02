using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace backend_api.Models
{
    public class NoticeBoardThread
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int threadID { get; set; }
        
        public string threadTitle{ get; set; }
        public string threadCreationDate { get; set; }
        public string threadContent { get; set; }
        
        [ForeignKey("User")]
        public int UserID { get; set; }
        
        private const int LEVEL = 4;

        public int getLevel()
        {
            return LEVEL;
        }

        public NoticeBoardThread()
        {
            
        }
       
    }
}