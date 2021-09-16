import http from 'k6/http';
import { sleep } from 'k6';

export let options = {
    insecureSkipTLSVerify: true,
    noConnectionRefuse: false,
    stages: [
        {duration: '2m', target: 100}, //below normal load
        {duration: '5m', target: 100},
        {duration: '2m', target: 200},//normal load
        {duration: '5m', target: 200},
        {duration: '2m', target: 300}, //breaking point
        {duration: '5m', target: 300},
        {duration: '2m', target: 400}, //beyond breaking point
        {duration: '5m', target: 400},
        {duration: '10m', target: 0},//recovery
    ],
};

export default ()=>{
    http.batch([
        ['GET', 'https://localhost:5001/api/Booking/GetBookings?UserId=79'],
        ['GET', 'https://localhost:5001/api/Node/GetAllNodes'],
    ]);
    
    sleep(1);
};