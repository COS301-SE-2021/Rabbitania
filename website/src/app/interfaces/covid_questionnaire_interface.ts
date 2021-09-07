export interface QuestionnaireRequest{
  cough: string,
  fever: string,
  sore_throat: string,
  shortness_of_breath: string,
  head_ache: string,
  gender: string,
  test_indication: string,
}

export interface QuestionnaireResponse{
  result: string
}
