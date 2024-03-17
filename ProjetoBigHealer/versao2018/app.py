from flask import Flask, render_template, redirect, url_for, flash, request
from flask_bootstrap import Bootstrap
from flask_wtf import FlaskForm 
from wtforms import StringField, PasswordField, BooleanField, SubmitField, SelectField
from wtforms.fields.html5 import DateField,DateTimeField
from datetime import datetime
from wtforms.validators import InputRequired, Email, Length
from flask_sqlalchemy  import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import LoginManager, UserMixin, login_user, login_required, logout_user, current_user


app = Flask(__name__)
app.config['SECRET_KEY'] = 'Thisissupposedtobesecret!'
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///database.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
bootstrap = Bootstrap(app)
db = SQLAlchemy(app)
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'login'

#Classes

class Usuario(UserMixin, db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(15), unique=True)
    email = db.Column(db.String(50), unique=True)
    password = db.Column(db.String(80))

class Paciente(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(20))
    nascimento = db.Column(db.Date)
    cpf = db.Column(db.String(11), unique=True) 
    sexo = db.Column(db.String(10))
    
class Prontuario(db.Model): #Consulta, Ficha de Atendimento#
    id = db.Column(db.Integer, primary_key=True)
    id_paciente = db.Column(db.Integer)
    nome_paciente = db.Column(db.Integer)
    datahoraentrada = db.Column(db.DateTime)
    pressao = db.Column(db.Integer)
    temperatura = db.Column(db.Integer)
    id_usuario = (db.Integer,db.ForeignKey('usuario.id'))
    datahorasaida = db.Column(db.DateTime) 
    
class Fila(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nome_paciente = db.Column(db.String(20))
    score = db.Column(db.Integer)
    status = db.Column(db.String)
    chegada = db.Column(db.DateTime)
    atendido = db.Column(db.DateTime) 

@login_manager.user_loader
def load_user(user_id):
    return Usuario.query.get(int(user_id))
    
#Formulários

class LoginForm(FlaskForm):
    username = StringField('Usuário', validators=[InputRequired(), Length(min=4, max=50)])
    password = PasswordField('Senha', validators=[InputRequired(), Length(min=8, max=80)])
    remember = BooleanField('Lembrar a senha')

class RegisterForm(FlaskForm):
    email = StringField('E-mail', validators=[InputRequired(), Email(message='Invalid email'), Length(max=150)])
    username = StringField('Usuário', validators=[InputRequired(), Length(min=4, max=50)])
    password = PasswordField('Senha', validators=[InputRequired(), Length(min=8, max=80)])
    submit = SubmitField("Registrar Usuário")

class InserirPacienteForm(FlaskForm):
    nome = StringField('Nome do paciente', validators=[InputRequired(), Length(max=50)])
    nascimento = DateField('Nascimento' , validators=[InputRequired()])
    cpf = StringField('CPF', validators=[InputRequired(), Length(min=11, max=14)])
    sexo = SelectField('Sexo',validators=[InputRequired()],choices=[('F','Feminino'),('M','Masculino')])
    submit=SubmitField("Cadastrar Paciente")    

class InserirProntuarioForm(FlaskForm):
    nome_paciente = StringField('Nome do Paciente', validators=[InputRequired(), Length(max=50)])
    datahoraentrada = DateTimeField('Data e Horário da Chegada',validators=[InputRequired()])
    respiracao = SelectField('respiracao',validators=[InputRequired()],choices=[('S','Sim'),('N','Não')])
    dorforte = SelectField('dorforte',validators=[InputRequired()],choices=[('S','Sim'),('N','Não')])
    dormedia = SelectField('dormedia',validators=[InputRequired()],choices=[('S','Sim'),('N','Não')])
    dorfraca = SelectField('dorfraca',validators=[InputRequired()],choices=[('S','Sim'),('N','Não')])
    semdor = SelectField('semdor',validators=[InputRequired()],choices=[('S','Sim'),('N','Não')])
    datahorasaida = DateTimeField('Data e Horário da Saída',validators=[InputRequired()])
    submit=SubmitField("enviar") 
    
@app.route('/')
def index():
    return render_template('index.tpl')

@app.route('/login', methods=['GET', 'POST'])
def login():
    formobj = LoginForm()
    msg=""
    if formobj.validate_on_submit():
        user = Usuario.query.filter_by(username=formobj.username.data).first()
        if user:
            if check_password_hash(user.password, formobj.password.data):
                login_user(user, remember=formobj.remember.data)
                return redirect(url_for('painelcontrole'))
                msg='<h1>Usuário ou Senha incorreta</h1>'
    return render_template('login.tpl', form=formobj,msg=msg)

@app.route('/registra', methods=['GET'])
def registra_get():
    form = RegisterForm()
    return render_template('registra.tpl', form=form)   

@app.route('/registra', methods=['POST'])
def registra_post():
    form = RegisterForm(request.form)
    if form.validate_on_submit():
        hashed_password = generate_password_hash(form.password.data, method='sha256')
        new_user = Usuario(username=form.username.data, email=form.email.data, password=hashed_password)
        db.session.add(new_user)
        db.session.commit()
        flash('Usuário criado','success')
        print ('usuário foi criado com sucesso')#aparece no CMD, mas nao no navegador#
        return redirect('/login')
    else:
        flash('Usuário não foi criado','danger')
        print('Usuario não foi criado',form.errors)#aparece no CMD, mas nao no navegador#
        return redirect('/registra')    

@app.route('/painelcontrole')
@login_required
def painelcontrole():
    return render_template('painelcontrole.tpl', name=current_user.username)        

@app.route('/pacientes')
@login_required
def pacientes():
    pacientes = Paciente.query.all()
    return render_template('pacientes.tpl', pacientes=pacientes)
        
@app.route('/paciente/inserir', methods=['GET'])
@login_required
def paciente_inserir_get():
    form = InserirPacienteForm()
    return render_template('paciente_inserir.tpl', form=form) 
    
@app.route('/paciente/inserir', methods=['POST'])
@login_required
def paciente_inserir_post():
    form = InserirPacienteForm(request.form)
    if form.validate_on_submit():
        new_paciente = Paciente (nome=form.nome.data,nascimento=form.nascimento.data,cpf=form.cpf.data,sexo=form.sexo.data)
        db.session.add(new_paciente)
        db.session.commit()
        flash('Paciente cadastrado com sucesso','success')
        print ('Paciente cadastrado com sucesso')#aparece no CMD, mas nao no navegador
    else:
        flash('Paciente não foi cadastrado','danger')
        print('Paciente não foi cadastrado',form.errors)#aparece no CMD, mas nao no navegador
    return redirect('/pacientes')   
    
@app.route('/paciente/editar/<int:_id_>',methods=['GET'])
@login_required
def paciente_editar_get(_id_):
    pacientes = Paciente.query.filter_by(id=_id_).first()
    return render_template('paciente_editar.tpl', paciente=pacientes)   
    
@app.route('/paciente/editar/<int:_id_>', methods=['POST'])
def paciente_editar_post(_id_):
    pacientes = Paciente.query.filter_by(id=_id_).first()
    #form = RegisterPacienteForm(obj=paciente)
    #print (form.cpf.data)
    nascimento = datetime.strptime(request.form.get("nascimento"),'%d/%m/%Y')
    print (nascimento)
    request.form.get("nascimento")
    pacientes.nome=request.form.get("nome")
    pacientes.nascimento=nascimento
    pacientes.cpf=request.form.get("cpf")
    pacientes.sexo=request.form.get("sexo")
    #if form.validate_on_submit():
    try:
            db.session.add(pacientes)
            db.session.commit()
            flash('Alterações realizadas com sucesso', 'success')
            print('sucesso')
    except Exception as e:
            flash ('erro','danger')
            print('erro',e)
    #else:
        #print('invalido', form.errors)
    return redirect('/pacientes')   

@app.route('/paciente/ver/<int:_id_>',methods=['GET'])
@login_required
def paciente_ver_get(_id_):
    pacientes = Paciente.query.filter_by(id=_id_).first()
    return render_template('paciente_ver.tpl', paciente=pacientes)
    
@app.route('/paciente/deletar/<int:_id_>',methods=['GET'])
@login_required
def paciente_deletar_get(_id_):
    pacientes = Paciente.query.filter_by(id=_id_).first()
    return render_template('paciente_deletar.tpl', paciente=pacientes)  

@app.route('/paciente/deletar/<int:_id_>',methods=['POST'])
@login_required
def paciente_deletar_post(_id_):
    pacientes = Paciente.query.filter_by(id=_id_).first()
    db.session.delete(pacientes)
    db.session.commit()
    return redirect('/pacientes')
    
@app.route('/prontuarios')
@login_required
def prontuarios():
    prontuarios = Prontuarios.query.all()
    return render_template('prontuarios.tpl', prontuarios=prontuarios)  

@app.route('/prontuario/inserir', methods=['GET'])
@login_required
def prontuario_inserir_get():
    form = InserirProntuarioForm()
    return render_template('prontuario_inserir.tpl', form=form) 
    
@app.route('/prontuario/inserir', methods=['POST'])
@login_required
def prontuario_inserir_post():
    form = InserirProntuarioForm(request.form)
    if form.validate_on_submit():
        new_prontuario= Prontuario (nome_paciente=form.nome_paciente.data,datahoraentrada=form.datahoraentrada.data,respiracao=form.respiracao.data,dorforte=form.dorforte.data,dormedia=form.dormedia.data,dorfraca=form.dorfraca.data,semdor=form.semdor.data,datahorasaida=form.datahorasaida.data,sexo=form.sexo.data)
        db.session.add(new_prontuario)
        db.session.commit()
        flash('Prontuario inserido com sucesso','success')
        print ('Prontuario inserido com sucesso')#aparece no CMD, mas nao no navegador
    else:
        flash('Prontuario não foi inserido no sistema','danger')
        print('Prontuario não foi inserido no sistema',form.errors)#aparece no CMD, mas nao no navegador
    return redirect('/prontuarios')     
     
@app.route('/deslogar')
@login_required
def logout():
    logout_user()
    return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(debug=True)
    
