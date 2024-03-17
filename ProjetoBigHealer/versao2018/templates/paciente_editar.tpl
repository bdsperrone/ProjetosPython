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
	<form action="/paciente/editar/{{paciente.id}}" method="POST">  
	<h2 class="sub-header">Editar os dados do Paciente</h2>
	<p>Nome:  <input type="text" name="nome" value="{{paciente.nome}}"/></p>
	<p>Nascimento:  <input type="text" name="nascimento" value="{{paciente.nascimento.strftime('%d/%m/%Y')}}"/></p>
	<p>CPF:  <input type="text" name="cpf" value="{{paciente.cpf}}"/></p>
	<select name="sexo">
	{%if paciente.sexo=="M"%}
	<option selected value="M">Masculino</option>
	<option value="F">Feminino</option>
	{%else%}
	<option selected value="F">Feminino</option>
	<option value="M">Masculino</option>
	{%endif%}
</select> 
	</p>
<button type="submit" class="btn btn-danger">Salvar alterações</button> 
 </div>
 </form> 
{% endblock %}

        

