using System.Collections.Generic;
using System.Threading.Tasks;
using backend_api.Models.Enumerations;
using backend_api.Models.Enumerations.Requests;
using backend_api.Models.Enumerations.Responses;

namespace backend_api.Data.Enumerations
{
    public interface IEnumRepository
    {
        Task<GetOfficeNameResponse> GetOfficeName(GetOfficeNameRequest request);
        
        Task<GetUserRoleTypeResponse> GetUserRoleType(GetUserRoleTypeRequest request);
        
        Task<GetOfficeIdResponse> GetOfficeId(GetOfficeIdRequest request);
        
        Task<GetUserRoleIdResponse> GetUserRoleId(GetUserRoleIdRequest request);
        
    }
}