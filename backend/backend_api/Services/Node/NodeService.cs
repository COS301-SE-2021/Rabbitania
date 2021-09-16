using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using backend_api.Data.Node;
using backend_api.Exceptions.Node;
using backend_api.Models.Node.Requests;
using backend_api.Models.Node.Responses;
using Hangfire;

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
            if (request != null)
            {
                var resp = await _nodeRepository.GetNode(request);
                return resp;
            }
            else
            {
                throw new InvalidNodeException("Request is null or node ID is missing");
            }
        }

        public async Task<CreateNodeResponse> CreateNode(CreateNodeRequest request)
        {
            if (request == null)
            {
                throw new InvalidNodeException("Request is null or empty");
            }
            if (request.UserEmail.Equals(null) || request.UserEmail.Length == 0)
            {
                throw new InvalidNodeException("User email is null");
            }

            var resp = await _nodeRepository.CreateNode(request);
            return resp;
        }

        public async Task<EditNodeResponse> EditNode(EditNodeRequest request)
        {
            if (request == null)
            {
                throw new InvalidNodeException("Request is null or empty");
            }

            if (request.NodeId == null)
            {
                throw new InvalidNodeException("Null node ID specified to edit");
            }
            var resp = await _nodeRepository.EditNode(request);
            return resp;
        }

        public async Task<DeleteNodeResponse> DeleteNode(DeleteNodeRequest request)
        {
            if (request == null)
            {
                throw new InvalidNodeException("Request is null or empty");
            }

            if (request.NodeId == null)
            {
                throw new InvalidNodeException("Null node ID specified to delete");
            }

            var resp = await _nodeRepository.DeleteNode(request);
            return resp;
        }

        public async Task<IEnumerable<Models.Node.Node>> GetAllNodes()
        {
            var resp = await _nodeRepository.GetAllNodes();
            return resp;
        }


        public async Task<ActivateNodeResponse> ActivateNode(ActivateNodeRequest request)
        {
            if (request == null)
            {
                throw new InvalidNodeException("Request is null or empty");
            }

            if (request.UserEmail == "")
            {
                throw new InvalidNodeException("Empty email is invalid");
            }

            var resp = await _nodeRepository.ActivateNode(request);
            return resp;
        }

        public async Task<DeactivateAllNodesResponse> DeactivateAllNodes(DeactivateAllNodesRequest request)
        {
            if (request != null)
            {
                var resp = await _nodeRepository.DeactivateAllNodes(null);
                return resp;
            }
            else
            {
                throw new InvalidNodeException("Request is null");
            }
        }

        public async Task<SaveNodesResponse> SaveNodes(SaveNodesRequest request)
        {
            if (request == null)
            {
                throw new InvalidNodeException("Request is null or empty");
            }

            if (request.Nodes.Count == 0)
            {
                throw new InvalidNodeException("Cannot save empty list of nodes");
            }

            return await _nodeRepository.SaveNodes(request);
        }
    }
}