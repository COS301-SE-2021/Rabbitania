export interface NodeGetAllRequest{
  id:number,
  userEmail: string,
  user: null,
  xPos: number,
  yPos: number,
  active: boolean
}
export interface NodeRequest{
  userEmail: string,
  xPos: number,
  yPos: number,
  active: boolean
}

export interface NodeResponse{
  response: string,
  statusCode: number
}