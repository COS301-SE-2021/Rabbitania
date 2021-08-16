using System;
using System.Threading.Tasks;
using backend_api.Data.Enumerations;
using backend_api.Exceptions.Enumerations;
using backend_api.Models.Enumerations.Requests;
using backend_api.Models.Enumerations.Responses;

namespace backend_api.Services.Enumerations
{
    public class EnumService : IEnumService
    {
        private readonly IEnumRepository _enumRepository;

        public EnumService(IEnumRepository enumRepository)
        {
            _enumRepository = enumRepository;
        }

        public async Task<GetOfficeNameResponse> GetOfficeName(GetOfficeNameRequest request)
        {
            if (request.OfficeLocation < 0)
            {
                throw new InvalidOfficeRequestException("Error with enumerations");
            }
            
            return await _enumRepository.GetOfficeName(request);
        }
        
        public async Task<GetUserRoleTypeResponse> GetUserRoleType(GetUserRoleTypeRequest request)
        {
            if (request.UserRole < 0)
            {
                throw new InvalidUserRoleTypeException("Error with enumerations");
            }
            
            return await _enumRepository.GetUserRoleType(request);
        }

        public async Task<GetOfficeIdResponse> GetOfficeId(GetOfficeIdRequest request)
        {
            if (request.OfficeName.Equals(""))
            {
                throw new InvalidOfficeRequestException("Error with enumerations");
            }
            
            return await _enumRepository.GetOfficeId(request);
        }

        public async Task<GetUserRoleIdResponse> GetUserRoleId(GetUserRoleIdRequest request)
        {
            if (request.RoleName.Equals(""))
            {
                throw new InvalidUserRoleTypeException("Error with enumerations");
            }
            
            return await _enumRepository.GetUserRoleId(request);
        }
    }
}