import http from 'k6/http';

export let options = {
    insecureSkipTLSVerify: true,
    noConnectionRefuse: false,
    vus: 1,
    duration: '10s'
};
export default ()=>{
  http.get('https://rabbitania-runtimeterrors.herokuapp.com/api/Booking/GetBookings?UserId=79');
  sleep(1);
};