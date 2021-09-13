namespace backend_api.Models.Node.Requests
{
    public class CreateNodeRequest
    {
        private string userEmail;
        private float xPos;
        private float yPos;
        private bool active;

        public CreateNodeRequest(string userEmail, float xPos, float yPos, bool active)
        {
            this.userEmail = userEmail;
            this.xPos = xPos;
            this.yPos = yPos;
            this.active = active;
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

        public bool Active
        {
            get => active;
            set => active = value;
        }
    }
}