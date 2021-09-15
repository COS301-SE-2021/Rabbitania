import { Component, HostListener, OnInit, ɵNOT_FOUND_CHECK_ONLY_ELEMENT_INJECTOR } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { HttpClient } from '@angular/common/http';
import { QuestionnaireRequest} from '../interfaces/covid_questionnaire_interface';
import { QuestionnaireResponse} from '../interfaces/covid_questionnaire_interface';
import { AiServiceService } from '../../app/services/AI/ai-service.service';
import { UserDetailsService } from '../services/user-details/user-details.service';
import { SignOutComponent } from '../sign-out/sign-out.component';
import { AuthService } from '../services/firebase/auth.service';
import { Router } from '@angular/router';
import { NodeServiceService } from '../services/ai-planner/node-service.service';
import { first } from 'rxjs/operators';
import { generate } from 'rxjs';
import { MovableNodes } from '../services/ai-planner/movable-nodes';
import { Graph } from '../interfaces/Graph';
import { GraphServiceService } from '../services/graph/graph-service.service';

@Component({
  selector: 'app-covid-questionnaire',
  templateUrl: './covid-questionnaire.component.html',
  styleUrls: ['./covid-questionnaire.component.scss']
})
export class CovidQuestionnaireComponent implements OnInit{
user_email = "";
nodes: MovableNodes[] = [];
screenHeight!: number;
screenWidth!: number;
screenRatio: number = 1;



  constructor(
    private fb: FormBuilder,
    private service : AiServiceService,
    private auth_service: AuthService,
    private userService: UserDetailsService,
    private router : Router,
    private nodeService: NodeServiceService,
    private graphService: GraphServiceService,
    ) { }

  async ngOnInit(){
  this.screenHeight = window.innerHeight;
  this.screenWidth = window.innerWidth;
  //console.log(this.screenHeight, this.screenWidth);

  if(this.screenWidth >= 1700)
  {
    this.screenRatio = 4
    this.getNodes(this.screenRatio);
  }
  else if(this.screenWidth >= 1100)
  {
    this.screenRatio = 2.5;
    this.getNodes(this.screenRatio);
  }
  else if(this.screenWidth >= 820)
  {
    this.screenRatio = 2;
    this.getNodes(this.screenRatio);
  }
  else if(this.screenWidth >= 720)
  {
    this.screenRatio = 1.6;
    this.getNodes(this.screenRatio);
  }
  else if(this.screenWidth >= 540)
  {
    this.screenRatio = 1.0;
    this.getNodes(this.screenRatio);
  }
  else
  {
    this.screenRatio = 0.8;
    this.getNodes(this.screenRatio);
  }
}

async getNodes(multiplier: number)
{

  var result = await this.nodeService.Get();
  result.subscribe(data => {
    if(data){
      this.nodes = [];
        for(var i =0; i< data.length;i++)
        {
          this.nodes.push(new MovableNodes(Number(data[i].id),Number(data[i].xPos)*multiplier,Number(data[i].yPos)*multiplier,data[i].userEmail,data[i].active))
        }
        console.log(this.nodes);
    }
  });
}

  covidQuestionnaire = this.fb.group({
    cough: false,
    fever: false,
    sore_throat: false,
    shortness_of_breath: false,
    head_ache: false,
    test_indication: false,
    gender: "male",
    });

  checkOnline(){
    if(this.user_email == "")
    {
      return false;
    }
    else return true;
  }

  async onSubmit(){
    console.log(this.checkOnline());
    if(this.checkOnline() == false){
      var res = await this.auth_service.signIn();
      if(res){
        this.user_email = this.userService.retrieveUserDetails().email;
        const questionnaireObject = this.covidQuestionnaire.value;

        var _cough = "0";
        var _fever = "0";
        var _sore_throat = "0";
        var _shortness_of_breath = "0";
        var _head_ache = "0";
        var _test_indication = "Other";
        var _gender = "male";

          if(questionnaireObject.cough == true){
            _cough = "1";
          }
          if(questionnaireObject.fever == true){
            _fever = "1";
          }
          if(questionnaireObject.sore_throat == true){
            _sore_throat = "1";
          }
          if(questionnaireObject.shortness_of_breath == true){
            _shortness_of_breath = "1";
          }
          if(questionnaireObject.head_ache == true){
            _head_ache = "1";
          }
          if(questionnaireObject.gender == "female"){
            _gender = "female";
          }
          if(questionnaireObject.test_indication == true){
            _test_indication = "Contact with confirmed"
          }

          var result = (await this.service.Post(_cough, _fever, _sore_throat, _shortness_of_breath, _head_ache, _gender, _test_indication))

          result.subscribe(async data => {
            if(data){
              console.log(data);
              if(data > 0.70){
                this.graphService.CreateGraph(this.nodes, this.user_email);
              }
            }
          });
          var activateResult = (await (this.service.Activate(this.user_email))).subscribe(async data => {
            if(data){
              console.log(data);
            }
          });

        }
      }
      else{
        this.user_email = await this.userService.retrieveUserDetails().email;
        const questionnaireObject = this.covidQuestionnaire.value;

        var _cough = "0";
        var _fever = "0";
        var _sore_throat = "0";
        var _shortness_of_breath = "0";
        var _head_ache = "0";
        var _test_indication = "Other";
        var _gender = "male";

          if(questionnaireObject.cough == true){
            _cough = "1";
          }
          if(questionnaireObject.fever == true){
            _fever = "1";
          }
          if(questionnaireObject.sore_throat == true){
            _sore_throat = "1";
          }
          if(questionnaireObject.shortness_of_breath == true){
            _shortness_of_breath = "1";
          }
          if(questionnaireObject.head_ache == true){
            _head_ache = "1";
          }
          if(questionnaireObject.gender == "female"){
            _gender = "female";
          }
          if(questionnaireObject.test_indication == true){
            _test_indication = "Contact with confirmed"
          }

          var result = (await this.service.Post(_cough, _fever, _sore_throat, _shortness_of_breath, _head_ache, _gender, _test_indication))

          result.subscribe(async data => {
            if(data){
              console.log(data);
            }
          });


          var activateResult = (await (this.service.Activate(this.user_email))).subscribe(async data => {
            if(data){
              console.log(data);
            }
          });


        }

      this.router.navigate(['/'], {
        queryParams: {

        },
        skipLocationChange: false
      });
    }
}




