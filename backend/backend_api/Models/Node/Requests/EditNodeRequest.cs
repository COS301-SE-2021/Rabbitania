namespace backend_api.Models.Node.Requests
{
    public class EditNodeRequest
    {
        private int nodeId;
        private float xPos;
        private float yPos;
        private string userEmail;
        private bool active;

        public int NodeId
        {
            get => nodeId;
            set => nodeId = value;
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

        public string UserEmail
        {
            get => userEmail;
            set => userEmail = value;
        }

        public bool Active
        {
            get => active;
            set => active = value;
        }

        public EditNodeRequest(int nodeId, bool active)
        {
            this.nodeId = nodeId;
            this.active = active;
        }

        public EditNodeRequest(int nodeId, float xPos, float yPos)
        {
            this.nodeId = nodeId;
            this.xPos = xPos;
            this.yPos = yPos;
        }

        public EditNodeRequest(int nodeId, float xPos, float yPos, bool active)
        {
            this.nodeId = nodeId;
            this.xPos = xPos;
            this.yPos = yPos;
            this.active = active;
        }

        public EditNodeRequest(int nodeId, float xPos, float yPos, string userEmail, bool active)
        {
            this.nodeId = nodeId;
            this.xPos = xPos;
            this.yPos = yPos;
            this.userEmail = userEmail;
            this.active = active;
        }
    }
}