namespace backend_api.Models.Node.Requests
{
    public class GetNodeRequest
    {
        private int nodeId;

        public GetNodeRequest(int nodeId)
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