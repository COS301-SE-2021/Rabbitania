using System.Collections.Generic;
using System.Threading.Tasks;
using backend_api.Models.Node.Requests;
using backend_api.Models.Node.Responses;

namespace backend_api.Services.Node
{
    public interface INodeService
    {
        /// <summary>
        ///     Create node object that checks the request object
        ///     and makes sure all checks pass
        /// </summary>
        /// <param name="request"></param>
        /// <returns> CreateNodeResponse </returns>
        Task<CreateNodeResponse> CreateNode(CreateNodeRequest request);
        /// <summary>
        ///     Validates if the request is valid and if so
        ///     returns a response object containing the node.
        /// </summary>
        /// <param name="request"></param>
        /// <returns> GetNodeResponse </returns>
        Task<GetNodeResponse> GetNode(GetNodeRequest request);
        /// <summary>
        ///     Updates specific parameters of a node - can be
        ///     just the coordinates or the coordinates and
        ///     user information.
        /// </summary>
        /// <param name="request"></param>
        /// <returns> EditNodeResponse </returns>
        Task<EditNodeResponse> EditNode(EditNodeRequest request);
        /// <summary>
        ///     Checks if the node exists in the database and if so
        ///     removes it from the database based on the id
        ///     in the request object.
        /// </summary>
        /// <param name="request"></param>
        /// <returns> DeleteNodeResponse </returns>
        Task<DeleteNodeResponse> DeleteNode(DeleteNodeRequest request);
        /// <summary>
        ///     Gets all nodes saved in the system.
        /// </summary>
        /// <param name="request"></param>
        /// <returns> IEnumerable<Node> </returns>
        Task<IEnumerable<Models.Node.Node>> GetAllNodes();

        /// <summary>
        ///     Checks if node exists in the database and if so
        ///     edits the active attribute.
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        Task<ActivateNodeResponse> ActivateNode(ActivateNodeRequest request);
        
        /// <summary>
        ///     Deactivates all nodes at the end of each day (11:59 pm)
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        Task<DeactivateAllNodesResponse> DeactivateAllNodes(DeactivateAllNodesRequest request);

        Task<SaveNodesResponse> SaveNodes(SaveNodesRequest request);
    }
}