using System.Threading.Tasks;
using backend_api.Models.Forum.Requests;
using backend_api.Models.Forum.Responses;

namespace backend_api.Services.Forum
{
    public interface IForumService
    {
        
        /// <summary>
        ///     Validates the request after which it will create a new Forum and store
        /// </summary>
        /// <param name="request"></param>
        /// <returns>An HTTPS status code stating whether the operation was successful or not</returns>
        Task<CreateForumResponse> CreateForum(CreateForumRequest request);
        
        /// <summary>
        ///     Validates whether or not the request is valid, if so returns a response with the desired
        ///     forum objects 
        /// </summary>
        /// <param name="request"></param>
        /// <returns>An HTTPS status code stating whether the operation was successful or not</returns>
        Task<RetrieveForumsResponse> RetrieveForums(RetrieveForumsRequest request);
        
        /// <summary>
        ///     Validates whether or not the request is valid, if so returns a response that will
        ///     inform the controller with information on whether the deletion was a success or
        ///     not.
        /// </summary>
        /// <param name="request"></param>
        /// <returns>An HTTPS status code stating whether the operation was successful or not</returns>
        Task<DeleteForumResponse> DeleteForum(DeleteForumRequest request);
        
        /// <summary>
        ///     Validates whether or not the request is valid, if so returns a response with the desired
        ///     forum objects 
        /// </summary>
        /// <param name="request"></param>
        /// <returns>An HTTPS status code stating whether the operation was successful or not</returns>
        Task<CreateForumThreadResponse> CreateForumThread(CreateForumThreadRequest request);
        
        /// <summary>
        ///     Validates whether or not the request is valid, if so returns a response with a list
        ///     of forum thread objects 
        /// </summary>
        /// <param name="request"></param>
        /// <returns>An HTTPS status code stating whether the operation was successful or not</returns>
        Task<RetrieveForumThreadsResponse> RetrieveForumThreads(RetrieveForumThreadsRequest request);
        
        /// <summary>
        ///     Deletes a forum thread if the request is valid. Returns a response.
        /// </summary>
        /// <param name="request"></param>
        /// <returns>An HTTPS status code stating whether the operation was successful or not</returns>
        Task<DeleteForumThreadResponse> DeleteForumThread(DeleteForumThreadRequest request);
        
        /// <summary>
        ///     Validates whether or not the request is valid, if so returns a response with the desired
        ///     forum objects 
        /// </summary>
        /// <param name="request"></param>
        /// <returns>An HTTPS status code stating whether the operation was successful or not</returns>
        Task<CreateThreadCommentResponse> CreateThreadComment(CreateThreadCommentRequest request);
        
        /// <summary>
        ///     Validates whether or not the request is valid, if so returns a response with the desired
        ///     forum objects 
        /// </summary>
        /// <param name="request"></param>
        /// <returns>An HTTPS status code stating whether the operation was successful or not</returns>
        Task<RetrieveThreadCommentsResponse> RetrieveThreadComments(RetrieveThreadCommentsRequest request);
        
        /// <summary>
        ///     Validates whether or not the request is valid, if so returns a response with the desired
        ///     forum objects 
        /// </summary>
        /// <param name="request"></param>
        /// <returns>An HTTPS status code stating whether the operation was successful or not</returns>
        Task<DeleteThreadCommentResponse> DeleteThreadComment(DeleteThreadCommentRequest request);
            
        /// <summary>
        ///     Validates whether or not the request is valid, if so returns a response with the desired
        ///     forum objects 
        /// </summary>
        /// <param name="request"></param>
        /// <returns>An HTTPS status code stating whether the operation was successful or not</returns>
        Task<RetrieveNumThreadsResponse> RetrieveNumThreads(RetrieveNumThreadsRequest request);
        
        /// <summary>
        ///     Validates whether or not the request is valid, if so returns a response with the desired
        ///     forum objects 
        /// </summary>
        /// <param name="request"></param>
        /// <returns>An HTTPS status code stating whether the operation was successful or not</returns>
        Task<EditForumResponse> EditForum(EditForumRequest request);
        
        /// <summary>
        ///     Validates whether or not the request is valid, if so returns a response with the desired
        ///     forum objects 
        /// </summary>
        /// <param name="request"></param>
        /// <returns>An HTTPS status code stating whether the operation was successful or not</returns>
        Task<EditForumThreadResponse> EditForumThread(EditForumThreadRequest request);
        
        /// <summary>
        ///     Validates whether or not the request is valid, if so returns a response with the desired
        ///     forum objects 
        /// </summary>
        /// <param name="request"></param>
        /// <returns>An HTTPS status code stating whether the operation was successful or not</returns>
        Task<EditThreadCommentResponse> EditThreadComment(EditThreadCommentRequest request);

        Task<bool> CreateForumThreadAPI(CreateForumThreadRequest request);
    }
}