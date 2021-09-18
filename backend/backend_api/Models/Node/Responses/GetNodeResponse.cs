namespace backend_api.Models.Node.Responses
{
    public class GetNodeResponse
    {
        private Node node;

        public GetNodeResponse(Node node)
        {
            this.node = node;
        }

        public Node Node
        {
            get => node;
            set => node = value;
        }
    }
}