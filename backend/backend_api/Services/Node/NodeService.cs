using System;
using System.Threading.Tasks;
using backend_api.Data.Node;
using backend_api.Models.Node.Requests;
using backend_api.Models.Node.Responses;

namespace backend_api.Services.Node
{
    public class NodeService : INodeService
    {
        private readonly INodeRepository _nodeRepository;

        public NodeService(INodeRepository nodeRepository)
        {
            _nodeRepository = nodeRepository;
        }

        /// <inheritdoc />
        public async Task<GetNodeResponse> GetNode(GetNodeRequest request)
        {
            if (request != null || request.NodeId != null)
            {
                var resp = await _nodeRepository.GetNode(request);
                return resp;
            }
            else
            {
                throw new Exception("Request is null or node ID is missing");
            }
        }
        
    }
}