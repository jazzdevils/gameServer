unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ScktComp, ExtCtrls;

const
  json_start = '__JSON__START__';
  json_end   = '__JSON__END__';
type
  TForm2 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button3: TButton;
    Timer1: TTimer;
    Button4: TButton;
    Button5: TButton;
    Button2: TButton;
    Button6: TButton;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit6: TEdit;
    ClientSocket1: TClientSocket;
    RadioGroup1: TRadioGroup;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Button10: TButton;
    procedure ClientSocket1Connect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ClientSocket1Disconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button10Click(Sender: TObject);
  private
    { Private declarations }

    sKey: String;

    iQuiz_Inx: Integer;

    str: WideString;

    iSecond: Integer;
  public
    { Public declarations }
    procedure CliConnect(Sender: TObject; Socket: TCustomWinSocket);
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button10Click(Sender: TObject);
var
  s: String;
begin
  s := json_start
    + '{"action":"playresult","ver":"1","connection_id":"'+ Edit7.Text +'"}'
    + json_end;


  if ClientSocket1.Socket.Connected then begin
    ClientSocket1.Socket.SendText(s);
    Memo1.Lines.Add('playerinfo -> server');
  end;
end;

procedure TForm2.Button11Click(Sender: TObject);
var
  s: String;
begin
  iSecond := 10;
  Timer1.Enabled := False;
  
  if iQuiz_Inx = 8 then begin
    s := json_start
      + '{"action":"playing","subaction":"choice","quiz_index":"'+ IntToStr(iQuiz_Inx)
          + '","choice_index":"' + TButton(Sender).Caption + '","quiz_last":"true","ver":"1","connection_id":"'+ Edit7.Text +'"}'
      + json_end;
  end
  else begin
    s := json_start
      + '{"action":"playing","subaction":"choice","quiz_last":"false","quiz_index":"'+ IntToStr(iQuiz_Inx)
          + '","choice_index":"' + TButton(Sender).Caption +'","ver":"1","connection_id":"'+ Edit7.Text +'"}'
      + json_end;
  end;



  if ClientSocket1.Socket.Connected then begin
    ClientSocket1.Socket.SendText(s);
    Memo1.Lines.Add('playing -> server');
    
    Button11.Enabled := False;
    Button12.Enabled := False;
    Button13.Enabled := False;
    Button14.Enabled := False;

    Inc(iQuiz_Inx);
  end;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  if RadioGroup1.ItemIndex = 0 then begin
    ClientSocket1.Host := '127.0.0.1';
    ClientSocket1.Port := 5027;
//    ClientSocket1.Port := 5858;
  end
  else begin
    ClientSocket1.Host := '54.186.222.206';
    ClientSocket1.Port := 5027;
  end;

  if ClientSocket1.Socket.Connected = False then
    ClientSocket1.Active := True;

  iQuiz_Inx := 0;
  Button6.Enabled := true;
  iSecond := 10;
end;

procedure TForm2.Button2Click(Sender: TObject);
var
  s: String;
begin
  s := json_start
    + '{"action":"playerinfo","ver":"1","connection_id":"'+ Edit7.Text +'"}'
    + json_end;


  if ClientSocket1.Socket.Connected then begin
    ClientSocket1.Socket.SendText(s);
    Memo1.Lines.Add('playerinfo -> server');
  end;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  if ClientSocket1.Socket.Connected then begin
    ClientSocket1.Active := False;

    iQuiz_Inx := 0;
    
    Button11.Enabled := False;
    Button12.Enabled := False;
    Button13.Enabled := False;
    Button14.Enabled := False;

    if Timer1.Enabled then
      Timer1.Enabled := False;
  end;
end;

procedure TForm2.Button4Click(Sender: TObject);
var
  s: String;
begin
  s := json_start
    + '{"action":"arrange","ver":"1","connection_id":"'+ Edit7.Text +'"}'
    + json_end;


  if ClientSocket1.Socket.Connected then begin
    ClientSocket1.Socket.SendText(s);
    Memo1.Lines.Add('arrange -> server');
  end;
end;

procedure TForm2.Button5Click(Sender: TObject);
var
  s: String;
begin
  s := json_start
    + '{'
    + '"action":"adduserinfo","ver":"1",'
    + '"competition_count":"' + Edit8.Text + '","'
    + 'name":"' + Edit5.Text + '","'
    + 'win_count":"' + Edit9.Text + '","'
    + 'lost_count":"' + Edit10.Text + '","'
    + 'tie_count":"' + Edit11.Text + '","'
    + 'level":"' + Edit12.Text + '","'
    + 'point":"' + Edit13.Text + '","'
    + 'q_type":"' + Edit14.Text + '","'
    + 'q_category_id":"' + Edit1.Text + '","'
    + 'q_subcategory_id":"' + Edit2.Text + '","'
    + 'play_type":"' + Edit3.Text + '","'
    + 'id":"' + Edit4.Text + '","'
    + 'picture_url":"'+ Edit6.Text + '","'
    + 'connection_id":"'+ Edit7.Text +'"}'
    + json_end;


  if ClientSocket1.Socket.Connected then begin
    ClientSocket1.Socket.SendText(s);
    Memo1.Lines.Add('adduserinfo -> server');
  end;
end;

procedure TForm2.Button6Click(Sender: TObject);
var
  s: string;
begin
  s := json_start
    + '{"action":"authentication","ver":"1"}'
    + json_end;


  if ClientSocket1.Socket.Connected then begin
    ClientSocket1.Socket.SendText(s);
    Memo1.Lines.Add('authentication -> server');
//    ClientSocket1.Socket.SendBuf(s, length(s))
    Button6.Enabled := False;
  end;
end;

procedure TForm2.Button7Click(Sender: TObject);
var
  s: string;
begin
  s := json_start
    + '{"action":"getquiz","ver":"1"}'
    + json_end;


  if ClientSocket1.Socket.Connected then begin
    ClientSocket1.Socket.SendText(s);
    Memo1.Lines.Add('getquiz -> server');
//    ClientSocket1.Socket.SendBuf(s, length(s))
  end;
end;

procedure TForm2.Button8Click(Sender: TObject);
var
  s: String;
begin
  s := json_start
    + '{"action":"getquiz","ver":"1","connection_id":"'+ Edit7.Text +'"}'
    + json_end;


  if ClientSocket1.Socket.Connected then begin
    ClientSocket1.Socket.SendText(s);
    Memo1.Lines.Add('getquiz -> server');
  end;
end;

procedure TForm2.Button9Click(Sender: TObject);
var
  s: String;
begin
  s := json_start
    + '{"action":"playready","ver":"1","connection_id":"'+ Edit7.Text +'"}'
    + json_end;


  if ClientSocket1.Socket.Connected then begin
    ClientSocket1.Socket.SendText(s);
    Memo1.Lines.Add('playready -> server');
  end;
end;

procedure TForm2.CliConnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  Memo1.Lines.Add('Connected : ');
end;

procedure TForm2.ClientSocket1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  button1.Enabled := false;
  
  Memo1.Lines.Add('Connected to Server : 5027');
end;

procedure TForm2.ClientSocket1Disconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  button1.Enabled := True;
  Memo1.Lines.Add('DisConnected to Server : 5027');
end;

procedure TForm2.ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
var
  status: String;
  ss: WideString;
begin
//  ss := UTF8Decode(Socket.ReceiveText);
  ss := Socket.ReceiveText;
  str := str + ss;

  while Pos(json_end, str) > 0 do begin
    Memo1.Lines.Add('-----------------------------------------------------------');
    Memo1.Lines.Add(str);
    Memo1.Lines.Add('-----------------------------------------------------------');

    
    if pos(json_end, str) > 0 then begin
      if pos('authentication', str) > 0 then begin
        delete(str, 1, pos('connection_id', str) + 15);
        Edit7.Text := Copy(str, 1, pos('"', str) -1);

        Memo1.Lines.Add('authentication <- server');
        sleep(100);

        button5.Click;
      end
      else if pos('adduserinfo', str) > 0 then begin
        Memo1.Lines.Add('adduserinfo <- server');
        sleep(100);

        Button4.Click;
      end
      else if pos('arrange', str ) > 0 then begin
        delete(str, 1 , pos('"status"', str)+ 9);
        status := copy(str, 1, 3);
        if status = '000' then begin
          Memo1.Lines.Add('arranged <- server');
          sleep(100);

          Button2.Click;
        end
        else begin
          Memo1.Lines.Add('waiting another player....');
        end;
      end
      else if pos('playerinfo', str) > 0 then begin
        Memo1.Lines.Add('');
        Memo1.Lines.Add(str);

        sleep(100);

        Button8.Click;
      end
      else if pos('getquiz', str) > 0 then begin
        Memo1.Lines.Add('');
        Memo1.Lines.Add(str);

        Button9.Click;
      end
      else if pos('playnext', str) > 0 then begin
        Memo1.Lines.Add('');
        Memo1.Lines.Add(str);

        delete(str, 1, Pos('quiz_index', str) + 12);
        Label18.Caption := 'Quiz_Index : ' + Copy(str, 1, 1);

        Button11.Enabled := True;
        Button12.Enabled := True;
        Button13.Enabled := True;
        Button14.Enabled := True;

        Timer1.Enabled := True;
      end
      else if (pos('playing', str) > 0) and (pos('choice', str) > 0) then begin
        Memo1.Lines.Add('');
        Memo1.Lines.Add(str);
      end
      else if pos('exceptionclose', str) > 0 then begin
        Memo1.Lines.Add('');

        Memo1.Lines.Add(str);

        Timer1.Enabled := False;
        ClientSocket1.Socket.Close;
      end
      else if pos('playend', str) > 0 then begin
        Memo1.Lines.Add('');

        Memo1.Lines.Add(str);

        Timer1.Enabled := False;
      end
      else if pos('playresult', str) > 0 then begin
        Memo1.Lines.Add('');

        Memo1.Lines.Add(str);

      end;

      delete(str, 1, Pos(json_end, str) + 13);
    end;
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  sKey := FormatDateTime('YYYYMMDDHHNNSS', now);
  Edit7.Text := sKey;
  Memo1.Lines.Add('Key: ' + sKey);
end;

procedure TForm2.Timer1Timer(Sender: TObject);
var
  s: String;
begin
  iSecond := iSecond - 1;
  
  Label19.Caption := 'Time : ' + IntToStr(iSecond);

  if iSecond = 0 then begin
    iSecond := 10;
    
    if iQuiz_Inx = 8 then begin
      s := json_start
          + '{"action":"playing","subaction":"timeout","quiz_index":"'+ IntToStr(iQuiz_Inx)
          + '","quiz_last":"true","ver":"1","connection_id":"'+ Edit7.Text +'"}'
          + json_end;
    end
    else begin
      s := json_start
      + '{"action":"playing","subaction":"timeout","quiz_last":"false","quiz_index":"'+ IntToStr(iQuiz_Inx)
          + '","ver":"1","connection_id":"'+ Edit7.Text +'"}'
      + json_end;
    end;

    Memo1.Lines.Add('playing -> server');

    if ClientSocket1.Socket.Connected then begin
      ClientSocket1.Socket.SendText(s);

      Button11.Enabled := False;
      Button12.Enabled := False;
      Button13.Enabled := False;
      Button14.Enabled := False;

      Inc(iQuiz_Inx);
    end;
  end;
end;

end.
