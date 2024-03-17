{% extends "bootstrap/base.html" %}
{% block html_attribs %} lang="pt-br"{% endblock %}
{% block title %}Score APP - Painel de Controle{% endblock %}

{% block styles %}
    {{super()}}
    <link rel="stylesheet" href="{{url_for('.static', filename='css/dashboard.css')}}">
{% endblock %}

{% block content %}
    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Modo Leitor de Tela</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="/painelcontrole">Score APP</a>
        </div>
       <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li><a href="/painelcontrole">Painel de Controle</a></li>
            <li><a href="#">Configurações</a></li>
            <li><a href="#">Perfil</a></li>
            <li><a href="{{ url_for('logout') }}">Deslogar</a></li>
          </ul>
          <form class="navbar-form navbar-right">
            <input type="text" class="form-control" placeholder="Procurar...">
          </form>
        </div>
      </div>
    </nav>

    <div class="container-fluid">
      <div class="row">
{% with messages = get_flashed_messages() %}
      {% if messages %}
       <ul class=flashes>
      {% for message in messages %}
       <li>{{ message }}</li>
      {% endfor %} 
      {% endif %}
      {% endwith %}
        <div class="col-sm-3 col-md-2 sidebar">
          <ul class="nav nav-sidebar">
            <li class="active"><a href="/painelcontrole">Painel de Controle<span class="sr-only">(current)</span></a></li>
            <li><a href="/pacientes">Pacientes</a></li>
            <li><a href="prontuarios">Prontuários</a></li>
          </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h1 class="page-header">Bem vindo(a), {{ name|safe }} !</h1>

          <div class="row placeholders">
            <div class="col-xs-6 col-sm-2 placeholder">
              <img src="{{url_for('static', filename='img/vermelho.png')}}" width="150" height="150" class="img-responsive" alt="Generic placeholder thumbnail">             
              <h4>Emergência</h4>
              <span class="text-muted">Atendimento imediato</span>
            </div>
            <div class="col-xs-6 col-sm-2 placeholder">
              <img src="{{url_for('static', filename='img/laranja.png')}}" width="150" height="150" class="img-responsive" alt="Generic placeholder thumbnail">             
              <h4>Muita Urgência</h4>
              <span class="text-muted">Atendimento em até 10 minutos</span>
            </div>
            <div class="col-xs-6 col-sm-2 placeholder">
               <img src="{{url_for('static', filename='img/amarelo.png')}}" width="150" height="150" class="img-responsive" alt="Generic placeholder thumbnail">             
              <h4>Urgência</h4>
              <span class="text-muted">Atendimento em até 1 hora</span>
            </div>
            <div class="col-xs-6 col-sm-2 placeholder">
               <img src="{{url_for('static', filename='img/verde.png')}}" width="150" height="150" class="img-responsive" alt="Generic placeholder thumbnail">             
              <h4>Pouca Urgência</h4>
              <span class="text-muted">Atendimento em até 2 horas</span>
            </div>
			<div class="col-xs-6 col-sm-2 placeholder">
               <img src="{{url_for('static', filename='img/azul.png')}}" width="150" height="150" class="img-responsive" alt="Generic placeholder thumbnail">             
              <h4>Não Urgente</h4>
              <span class="text-muted">Atendimento em até 4 horas</span>
            </div>
          </div>

          <h2 class="sub-header">Fila de Atendimento</h2>
          <div class="table-responsive">
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>#</th>
                  <th>Paciente</th>
                  <th>Observação</th>
                  <th>Gravidade</th>
                  <th>Tempo</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>dado1</td>
                  <td>dado2</td>
                  <td>dado3</td>
                  <td>dado4</td>
                  <td>dado5</td>
                </tr>
                <tr>
                  <td>dado1</td>
                  <td>dado2</td>
                  <td>dado3</td>
                  <td>dado4</td>
                  <td>dado5</td>
                </tr>
                <tr>
                  <td>dado1</td>
                  <td>dado2</td>
                  <td>dado3</td>
                  <td>dado4</td>
                  <td>dado5</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
{% endblock %}