namespace backend_api.Models.Node.Requests
{
    public class DeleteNodeRequest
    {
        private int nodeId;

        public DeleteNodeRequest(int nodeId)
        {
            this.nodeId = nodeId;
        }

        public int NodeId
        {
            get => nodeId;
            set => nodeId = value;
        }
    }
}