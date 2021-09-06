using System.Threading.Tasks;
using backend_api.Models.Node.Requests;
using backend_api.Models.Node.Responses;

namespace backend_api.Services.Node
{
    public interface INodeService
    {
        Task<CreateNodeResponse> CreateNode(CreateNodeRequest request);
        Task<GetNodeResponse> GetNode(GetNodeRequest request);
    }
}