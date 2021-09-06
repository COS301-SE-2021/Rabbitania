namespace backend_api.Models.Node.Requests
{
    public class CreateNodeRequest
    {
        private string userEmail;
        private float xPos;
        private float yPos;
        private bool actice;

        public CreateNodeRequest(string userEmail, float xPos, float yPos, bool actice)
        {
            this.userEmail = userEmail;
            this.xPos = xPos;
            this.yPos = yPos;
            this.actice = actice;
        }

        public string UserEmail
        {
            get => userEmail;
            set => userEmail = value;
        }

        public float XPos
        {
            get => xPos;
            set => xPos = value;
        }

        public float YPos
        {
            get => yPos;
            set => yPos = value;
        }

        public bool Actice
        {
            get => actice;
            set => actice = value;
        }
    }
}