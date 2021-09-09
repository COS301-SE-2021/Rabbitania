export interface NodeRequest{
  userEmail: string,
  xPos: number,
  yPos: number,
  actice: boolean
}

export interface NodeResponse{
  response: string,
  statusCode: number
}