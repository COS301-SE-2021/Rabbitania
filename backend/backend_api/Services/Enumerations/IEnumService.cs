using System.Threading.Tasks;
using backend_api.Models.Enumerations.Requests;
using backend_api.Models.Enumerations.Responses;

namespace backend_api.Services.Enumerations
{
    public interface IEnumService
    {
        Task<GetOfficeNameResponse> GetOfficeName(GetOfficeNameRequest request);

        Task<GetUserRoleTypeResponse> GetUserRoleType(GetUserRoleTypeRequest request);
        
        Task<GetOfficeIdResponse> GetOfficeId(GetOfficeIdRequest request);
        
        Task<GetUserRoleIdResponse> GetUserRoleId(GetUserRoleIdRequest request);
        
    }
}