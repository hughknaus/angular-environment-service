import { Component, Input, OnInit } from '@angular/core';
import { EnvironmentService } from './environment.service';

@Component({
  selector: 'hello',
  template: `<h1>Hello {{name}}!</h1>`,
  styles: [`h1 { font-family: Lato; }`],
})
export class HelloComponent implements OnInit {
  @Input() name: string;

  constructor(private envService: EnvironmentService) {}

  ngOnInit() {
    this.name += ` ${this.envService.getValue('apiUrl')}`;
  }
}
