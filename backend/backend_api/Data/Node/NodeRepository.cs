using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using backend_api.Data.User;
using backend_api.Models.Node.Requests;
using backend_api.Models.Node.Responses;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.Node
{
    public class NodeRepository : INodeRepository
    {
        private readonly NodeContext _nodes;
        private readonly UserContext _users;

        public NodeRepository(NodeContext nodes)
        {
            _nodes = nodes;
        }

        public NodeRepository(NodeContext nodes, UserContext users)
        {
            _nodes = nodes;
            _users = users;
        }

        public async Task<GetNodeResponse> GetNode(GetNodeRequest request)
        {
            var resp = await _nodes.Nodes.FirstOrDefaultAsync(x => x.Id == request.NodeId);
            return new GetNodeResponse(resp);
        }

        public async Task<IEnumerable<Models.Node.Node>> GetAllNodes()
        {
            return await _nodes.Nodes.ToListAsync();
        }
        public async Task<DeleteNodeResponse> DeleteNode(DeleteNodeRequest request)
        {
            var node = await _nodes.Nodes.FirstOrDefaultAsync(x => x.Id == request.NodeId);
            try
            {
                _nodes.Entry(node).State = EntityState.Deleted;
                var deleted = await _nodes.SaveChangesAsync();
                if (deleted >= 0)
                {
                    return new DeleteNodeResponse("Node: " + request.NodeId + " successfully deleted",
                        HttpStatusCode.OK);
                }
                else
                {
                    return new DeleteNodeResponse("Error when attempting to delete node " + request.NodeId,
                        HttpStatusCode.BadRequest);
                }
            }
            catch (Exception e)
            {
                return new DeleteNodeResponse(e.Message, HttpStatusCode.BadRequest);
            }
        }

        public async Task<EditNodeResponse> EditNode(EditNodeRequest request)
        {
            var node = await _nodes.Nodes.FindAsync(request.NodeId);
            
            if (node != null)
            {
                try
                {
                    if(request.Active != null)
                        node.active = request.Active;
                    if(request.UserEmail!=null)
                        node.userEmail = request.UserEmail;
                    if(request.XPos != null)
                        node.xPos = request.XPos;
                    if(request.YPos != null)
                        node.yPos = request.YPos;
                    await _nodes.SaveChangesAsync();
                    return new EditNodeResponse("Node " + request.NodeId + " edited successfully", HttpStatusCode.OK);
                }
                catch (Exception e)
                {
                    return new EditNodeResponse(e.Message, HttpStatusCode.BadRequest);
                }
            }
            else
            {
                return new EditNodeResponse("Node that you are trying to update is null");
            }
        }
        public async Task<CreateNodeResponse> CreateNode(CreateNodeRequest request)
        {
            var node = new Models.Node.Node(request.UserEmail, request.XPos, request.YPos, false);
            
            try
            {
                var result = await _nodes.Nodes.AddAsync(node);
                var nodeID = result.Entity.Id;
                var user = await _users.UserEmail.FirstOrDefaultAsync(x => x.UsersEmail == request.UserEmail);
                var userID = user.UserId;
                
                var nodeUpdate = await _nodes.Nodes.FirstOrDefaultAsync(x => x.Id == nodeID);
                try
                {
                    nodeUpdate.user.UserId = userID;
                    await _nodes.SaveChangesAsync();
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                }
                await _nodes.SaveChangesAsync();
                return new CreateNodeResponse("Node created successfully with userID: "+userID+" and node ID: "+nodeID, HttpStatusCode.Created);
            }
            catch (Exception e)
            {
                return new CreateNodeResponse(e.Message, HttpStatusCode.BadRequest);
            }
        }

        public async Task<ActivateNodeResponse> ActivateNode(ActivateNodeRequest request)
        {
            try
            {
                var user = await _users.UserEmail.FirstOrDefaultAsync(x => x.UsersEmail == request.UserEmail);

                var nodeToUpdate = await _nodes.Nodes.FirstOrDefaultAsync(x => x.userEmail == user.UsersEmail);
                try
                {
                    nodeToUpdate.active = true;
                    await _nodes.SaveChangesAsync();
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                }

                return new ActivateNodeResponse("Node successfully activated", HttpStatusCode.OK);
            }
            catch (Exception e)
            {
                return new ActivateNodeResponse(e.Message, HttpStatusCode.BadRequest);
            }
        }

        public async Task<DeactivateAllNodesResponse> DeactivateAllNodes(DeactivateAllNodesRequest request)
        {
            var nodes = await _nodes.Nodes.ToListAsync();

            foreach (var node in nodes)
            {
                node.active = false;
            }

            await _nodes.SaveChanges();
            return new DeactivateAllNodesResponse("Nodes successfully deactivated", HttpStatusCode.OK);
        }
    }
}