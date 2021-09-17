namespace backend_api.Models.Node.Responses
{
    public class GetNodeResponse
    {
        private Node _node;

        public GetNodeResponse(Node node)
        {
            this._node = node;
        }

        public Node Node
        {
            get => _node;
            set => _node = value;
        }
    }
}