using System.Collections.Generic;

namespace backend_api.Models.Node.Requests
{
    public class SaveNodesRequest
    {
        private List<Node> nodes;

        public SaveNodesRequest(List<Node> nodes)
        {
            this.nodes = nodes;
        }

        public List<Node> Nodes
        {
            get => nodes;
            set => nodes = value;
        }
    }
    
}