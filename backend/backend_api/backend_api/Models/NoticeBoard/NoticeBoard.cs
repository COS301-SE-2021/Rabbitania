using System.Collections;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using backend_api.Models;

namespace backend_api.Models
{
    public class NoticeBoard
    {
        [Key] 
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int NoticeBoardID { get; set; }
        
        [ForeignKey("NoticeBoardThread")]
        public List<int> noticeBoardThreadIDs { get; set; }
        public string title { get; set; }

        //Return number of threads on the notice board
        public int getNumberOfThreads()
        {
            return noticeBoardThreadIDs.Count;
        }
    }
}