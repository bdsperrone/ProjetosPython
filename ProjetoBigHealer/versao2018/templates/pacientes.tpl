{% extends "bootstrap/base.html" %}
{% import "bootstrap/wtf.html" as wtf %}
{% block html_attribs %} lang="pt-br"{% endblock %}
{% block title %}Score APP - Pacientes{% endblock %}

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
	

<div class="table-responsive">
    <table class="table table-striped">
	<h2 class="sub-header">Pacientes</h2>
        <thead>
            <tr>
                 <th>Sequencia</th>
				<th>Nome</th>
                <th>Nascimento</th>
                <th>CPF</th>
                <th>Sexo</th>
				<th><a href="/paciente/inserir" class="btn btn-primary btn-md">Cadastrar novo Paciente no Sistema</a></th>
            </tr>
        </thead>
        <tbody>
             {% for paciente in pacientes %}
						<tr>
						  <td>{{paciente.id}}</td>
						  <td>{{paciente.nome}}</td>
						  <td>{{paciente.nascimento.strftime('%d/%m/%Y')}}</td>
						  <td>{{paciente.cpf}}</td>
						  <td>{{paciente.sexo}}</td>
						   <td>
						   <a class="btn btn-info" href="/paciente/ver/{{paciente.id}}">Ver</a>
						   <a class="btn btn-primary" href="/paciente/editar/{{paciente.id}}">Editar</a>
						   <a class="btn btn-danger" href="/paciente/deletar/{{paciente.id}}">Deletar</a> 
						   </td>
						</tr>
				{% endfor %}
        </tbody>
    </table>
</div>
{% endblock %}

        

