using System.Linq;
using System.Threading.Tasks;
using backend_api.Models.Enumerations;
using backend_api.Models.Enumerations.Requests;
using backend_api.Models.Enumerations.Responses;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.Enumerations
{
    public class EnumRepository : IEnumRepository
    {
        private readonly EnumContext _enums;

        public EnumRepository(EnumContext enums)
        {
            _enums = enums;
        }

        public async Task<GetOfficeNameResponse> GetOfficeName(GetOfficeNameRequest request)
        {
            var officeName = await _enums.OfficeLocations
                .Where(x => x.OfficeLocation == request.OfficeLocation).FirstOrDefaultAsync();
            
            var response = new GetOfficeNameResponse(officeName.Name);

            return response;
        }
        
        public async Task<GetUserRoleTypeResponse> GetUserRoleType(GetUserRoleTypeRequest request)
        {
            var userRoleType = await _enums.UsersRoles
                .Where(x => x.UserRole == request.UserRole).FirstOrDefaultAsync();
            
            var response = new GetUserRoleTypeResponse(userRoleType.Type);

            return response;
        }

        public async Task<GetOfficeIdResponse> GetOfficeId(GetOfficeIdRequest request)
        {
            var officeId = await _enums.OfficeLocations
                .Where(x => x.Name == request.OfficeName).FirstOrDefaultAsync();
            
            var response = new GetOfficeIdResponse(officeId.OfficeLocation);

            return response;
        }

        public async Task<GetUserRoleIdResponse> GetUserRoleId(GetUserRoleIdRequest request)
        {
            var userRoleId = await _enums.UsersRoles
                .Where(x => x.Type == request.RoleName).FirstOrDefaultAsync();
            
            var response = new GetUserRoleIdResponse(userRoleId.UserRole);

            return response;
        }
    }
}