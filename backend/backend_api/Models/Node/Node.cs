using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using backend_api.Models.User;

namespace backend_api.Models.Node
{
    public class Node
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        public string userEmail { get; set; }
        public Users user { get; set; }
        public float xPos { get; set; }
        public float yPos { get; set; }
        public bool active { get; set; }

        public Node()
        {
        }

        public Node(int id, string userEmail, float xPos, float yPos, bool active)
        {
            Id = id;
            this.userEmail = userEmail;
            this.xPos = xPos;
            this.yPos = yPos;
            this.active = active;
        }
    }
}