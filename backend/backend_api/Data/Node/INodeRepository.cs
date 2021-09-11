using System.Collections.Generic;
using System.Net;
using System.Threading.Tasks;
using backend_api.Models.Node.Requests;
using backend_api.Models.Node.Responses;

namespace backend_api.Data.Node
{
    public interface INodeRepository
    {
        Task<GetNodeResponse> GetNode(GetNodeRequest request);
        Task<CreateNodeResponse> CreateNode(CreateNodeRequest request);
        Task<IEnumerable<Models.Node.Node>> GetAllNodes();
        Task<DeleteNodeResponse> DeleteNode(DeleteNodeRequest request);
        Task<EditNodeResponse> EditNode(EditNodeRequest request);
        Task<ActivateNodeResponse> ActivateNode(ActivateNodeRequest request);
        Task<DeactivateAllNodesResponse> DeactivateAllNodes(DeactivateAllNodesRequest request);
        Task<SaveNodesResponse> SaveNodes(SaveNodesRequest request);
    }
}