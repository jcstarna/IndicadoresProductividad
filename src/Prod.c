///////////////////////////////////////////////////////////////////////////////
//                    PROYECTO INDICADORES PRODUCTIVIDAD
// VERSION PARA BAYSUR CON % CON UN DECIMAL
//
///////////////////////////////////////////////////////////////////////////////


#include <16f886.h>                          // Definiciones del PIC 16F873
#RESERVE   0x07B:0X07F
#fuses HS,NOWDT,NOPROTECT,NOLVP,NOBROWNOUT,NOMCLR,NODEBUG,NOPUT,BROWNOUT
#use delay(clock=20000000)                     // Oscilador a 20 Mhz
#priority RTCC,RDA,TBE

#pragma use fast_io(A)
#pragma use fast_io(B)
#pragma use fast_io(C)
#use rs232(baud=19200, BITS=8, xmit=PIN_C6, rcv=PIN_C7, enable=PIN_C5, ERRORS)// RS232 Estándar
#use I2C(master, sda=PIN_C4, scl=PIN_C3, force_hw, fast=100000)

//PINES DEL SHIFT REGISTER
#define pMR_SR    pin_B2  //MASTER RESET DEL SHIFT REGISTER
#define pDCLK_SR  pin_B3  //DATA CLOCK DEL SHIFT REGISTER   
#define pSCLK_SR  pin_B4  //STORAGE CLOCK DEL SHIFT REG
#define pOE_SR    pin_B5  //OUTPUT ENABLE DEL SHIFT REGISTER
#define pDATA_SR  pin_B6  //DATA DEL SHIFT REGISTER

//varios
#define pBUZZ  pin_B7     //BUZZER 
#define pREL1  pin_C0
#define pREL2  pin_C1
#define pRES   pin_C2     //libre

int const kInmuni=10;
int const k1seg=99;//2
int const k100ms=10;
int const kFiltro=15;
int const kP2=15;

// VARIABLES EN RAM ///////////////////////////////////////////////////////////
/////////////////////////////////////////////////////
// REGISTROS MODBUS
/////////////////////////////////////////////////////
int16 rCmd=0;           //40001 comando
int16 rSetTime=0;       //40002 hora, minuto y segundo a setear en el DS en BCD
int16 rSetDate=0;       //40003 Dia de la semana/fecha/mes/anio a setear en el DS en BCD
int16 rTime=0;          //40004 hora, minuto y segundo actual BCD
INT16 rMinutosDec=0;    //minutos en formato decimal
//int16 rDate=0;        //40005 Dia de la semana/fecha/mes/anio BCD
//
int16 rProdHs=1;        //40006 producido horario, se resetea hora a hora
int16 rProdHrAnt=2;     //40007 cantidad producida en la hora anterior
int16 rProdHora=3;      //40008 productividad horaria
int16 rObjHs=4;         //40009 objetivo horario
//
int16 rProdAcu=5;       //40010 Productividad acumulada
int16 rProdTurno=6;     //40011 Produccion acumulada del turno
int16 rProdTurnoAnt=7;  //40012 producido turno anterior
int16 rTempObjHs=8;     //40013 temporario de produccion horaria para cuando se cambia el objetivo de la horaen el medio de una hora
int16 rUltTiempo=9;     //40014 demora ultima prenda (tiempo entre pulsado y pulsado de puls fin
int16 rDatoListo=10;    //40015 //le indica al scada que recolecte el dato
int16 rAuxTiempo=11;     //40016 tiempo de prenda actual
//turnos
int16 rIniT1=12;         //40017 inicio turno uno byte superior, hora, byte inferior, minutos
int16 rFinT1=13;         //40018 fin turno idem formato
int16 rIniT2=14;         //40019
int16 rFinT2=15;         //40020
int16 rIniT3=16;         //40021
int16 rFinT3=17;         //40022
int16 rIniT4=18;         //40023
int16 rFinT4=19;         //40024
int16 rTurnoAct=20;      //40025
int16 rTurnoAnt=21;      //40026
int16 rObjDia=22;        //40027
int16 rPantalla=23;      //40028 pantalla a mostrar, datos hr, datos turno, etc 
int16 rIniRecT1=24;      //40029 recreo en el turno 1
int16 rFinRecT1=25;      //40030 recreo en el turno 1
int16 rIniRecT2=26;      //40031 recreo en el truno 2
int16 rFinRecT2=27;      //40032 recreo en el turno 2
int16 rIniRecT3=28;      //40033 recreo en el turno 3
int16 rFinRecT3=29;      //40034 recreo en el turno 3
int16 rIniRecT4=30;      //40035 recreo en el truno 4
int16 rFinRecT4=31;      //40036 recreo en el turno 4
int16 rObjAcu=0;         //40037 objetivos acumulados durante el turno
int16 rObjHsAnt=4;       //para detectar cambio de objetivo horario
int16 rContMin=0;        //contador de minutos para set de flag cada una hora


//1ra linea de digitos
int8  rMilL1=0;
int8  rCenL1=0;
int8  rDecL1=0;
int8  rUniL1=0;
//2da linea de digitos
int8  rMilL2=0;
int8  rCenL2=0;
int8  rDecL2=0;
int8  rUniL2=0;
//3da linea de digitos
int8  rMilL3=0;
int8  rCenL3=0;
int8  rDecL3=0;
int8  rUniL3=0;
//4da linea de digitos (hora)
int8  rMilL4=0;
int8  rCenL4=0;
int8  rDecL4=0;
int8  rUniL4=0;
int8  rLeds=0;


//variables para mostrar cuando finaliza el turn
int16 rTempObjDia=0;
int16 rTempProdTurno=0;
int16 rTempProdAcu=0;
int16 rIniRecredo=0;
int16 rObjAcuTurnoAnt=0;
//VARIABLES para display
int8  rFiltro=kFiltro;  //tiempo en segundos entre fin de prenda y fin de prenda
//colocados en funcion de como estan en la cadena de los shift registers
int8  rtemp=0;
int8  pDig=0;  //puntero al digito a enviar al shift
//variables de la funcion de conversion a unidad decena y centena
int8  rUMil=0;
int8  rCent=0;
int8  rDec=0;
int8  rUni=0;

//leds pirania

int8 dec_bcd[11]={0xC0,0xF9,0xA4,0xB0,0x99,0x92,0x82,0xF8,0x80,0x98,0xFF};//0x99 en 4

int8   rT1s=k1seg;
int8   rT100ms=k100ms;
int8   rMinIniRecDec=0; //minutos de inicio de recreo en la hora que hay recreo
int8   rMinFinTurnoDec=0; //minutos de fin de turno en la hora se inicia

//flag de teclado
int1  fTeclaOK=0;
int1  fIn1=0;
int1  fIn2=0;
int1  fIn3=0;
int1  fIn4=0;
int1  fTecOk=0;      //flag que la tecla ok se mantuvo apretada
int1  fGuardarEEPROM=0;
int8  rInmunidad=0;

//variables de turno
int8    rCantTurnos=0;
int8    rHoraIni=0;        //hora de inicio turno
int8    rMinutoIni=0;      //idem
int8    rHoraFin=0;        //hora de Fin turno
int8    rMinutoFin=0;      //idem
int8    rUni_MinAnt=0;     //minuto anterior, para saber cuando cambio el minuto y controlar cambiio de turno

//VARIABLES DS1307
INT8  rDec_HS=0;
INT8  rUni_HS=0;
INT8  rDec_MIN=0;
INT8  rUni_MIN=0;
INT8  rDec_SEC=0;
INT8  rUni_SEC=0;
int8  rHora=0;       //hora actual
int8  rMinuto=0;     //minuto actual
int8  rSegundos=0;
int8  rp2=kP2;
int8  rHIniRec=0;    //hora de inicio del recreo segun el turno
int8  rMIniRec=0;    //Minutos de inicio del recreo segun el turno

int8  rHFinTurno=0;    //en esta hora finaliza el turno
int8  rMFinTurno=0;    //Minutos de fin de turno

int1 p1seg=0;
int1 fFinHora=0;
int1 fIniTurno=0;
int1 fFinTurno=0;
int1 fTestTurno=0;
int1 f1Min=0;        //flag cada un minuto
int1 f100ms=0;
int1 fTimbre=0;      //hace sonar el timbre puesto en el rele 1
int1 fHora=0;        //flag cada una hora
int1 fRecreo= 0;     //esta en recreo
int1 fAuxRecreo=0;
int1 fAlarma=0;
int1 fFinGrabar=0;
int1 fPantalla=0;    //para mostrar por un tiempo la pantalla 2
int1 fPantTemp=0;
int1 fFiltro=0;      //filtro para evitar que pulsen seguido el fin de prenda
int1 fFinRecreo=0;
int1 fIniRecreo=0;
int1 rTempBool=0;


// librerias modbus
#include "modbus.h"
#include "modbus.c"

// Declaración de Funciones ///////////////////////////////////////////////////
void timbre(int16 patron);  
void envia_disp(void);                            
VOID ds1307_init(void);
void ds1307_read (void);
void ds1307_Write_time(int8 sec, int8 min, int8 hs);
void inc_dig(void);
void TestTurno(void);
void TestRecreo(void);
void Dec_A_UDCU(int16 nro);///descompone un numero en unidad mil, centena, decena y unidad
vOID WRITE_WORD_EEPROM(long int Dir, int16 data);
INT16 READ_WORD_EEPROM(long int n);
void graba_EEPROM(void);
void lee_EEPROM(void);
void CalcProd(void);
void TestCambioOBJ (void);
//++++++++++++++++++ ESCANEO DE ENTRADAS ++++++++++++++++++++++++++++++
void  ScanTeclado(){
//revision para placa nueva con teclado separado de placa principal

   int rTempTec;                          //Temporal teclado
//   set_tris_b (0b11111000);               //configuro entradas para teclas.
   rTempTec=input_A();
   rTempTec=rTempTec & 0b00001111;
      if (rTempTec!=15) //si=0 ninguna tecla apretada... me voy
         {
         rInmunidad--;
            if(rInmunidad==0 && fTeclaOK==0){
               rInmunidad=kInmuni;
               switch (rTempTec){
                           case 14:fIn4=1;       //14
                                   fTeclaOK=1;
                                   break;
                           case 13:fIn3=1;
                                   fTeclaOK=1;
                                   break;
                           case 11:fIn2=1;
                                   fTeclaOK=1;
                                   break;
                           case 7: fIn1=1;
                                   fTeclaOK=1;
                                   break;
                           default:fTeclaOK=0;
                                   rInmunidad=kInmuni;
                                   fIn1=0;
                                   fIn2=0;
                                   fIn3=0;
                                   fIn4=0;
                                   fTecOk=0;
                                   break;
                                 }
               }
            }
      else{
      rInmunidad=kInmuni;
      fTeclaOK=0;
      }
}


// INTERRUPCIONES /////////////////////////////////////////////////////////////
//++++++++++++++++++++++++++++++++++++++
//  RECEPCION SERIE.
//++++++++++++++++++++++++++++++++++++++
#int_rda
void serial_isr() {                    // Interrupción recepción serie USART
char rcvchar=0x00;
rcvchar=0x00;                        // Inicializo caracter recibido
   if(kbhit()){                           // Si hay algo pendiente de recibir ...
      rcvchar=getc();                     // lo descargo y ...
      ModBusRX(rcvchar);                // lo añado al buffer y ...
   }
   setup_timer_2 (T2_DIV_BY_16, 250, 16); //setup_timer_2 (T2_DIV_BY_4, 250, 16);
}

//++++++++++++++++++++++++++++++++++++++
//  TRANSMISION SERIE.
//++++++++++++++++++++++++++++++++++++++
#INT_TBE
void serial_tx(){
      ModBusTX();
}


//++++++++++++++++++++++++++++++++++++++
//  TIMER CERO.
//++++++++++++++++++++++++++++++++++++++
#int_RTCC
void RTCC_isr() {                // Interrupción Timer 0
set_timer0(60);
scanteclado();
if (--rT1s==0){
   p1seg=1;
   rT1s=k1seg;
   if(fFiltro){
      if(--rFiltro==0){
         rFiltro=kFiltro;
         fFiltro=0;
      }
   }
}
if (--rT100ms==0 & !fRecreo){
   rAuxTiempo++;                    //incremento tiempo de prenda actual
   rT100ms=k100ms;
   f100ms=1;
}

}


///////// INTERRUPCION DEL TIMER 2  ////////////
// inactividad del bus 485
////////////////////////////////////////////////
#INT_TIMER2
void timer2_isr(){
int16 CRC=0;
int16 CRC_Leido=0;
   IF(fParami){                        //Calculo checksum de dato recibido
         CRC=CRC_Calc(rxbuff,rxpuntero-3); //
         CRC_Leido= make16(rxBuff[rxpuntero-2],rxBuff[rxpuntero-1]);
         if(CRC_Leido==CRC)flagcommand=1;
         setup_timer_2(T2_DISABLED,0,1);
         rxpuntero=0;
         }
   else{
         inicbuffRX();
         rxpuntero=0;
         }
} 


#int_TIMER1   //Timer 1 overflow
void TIMER1_int(){

}



//,,,,,,,,,,,,Programa Principal /////////////////////////////////////////////////////////

void main() {
   delay_ms(500);
   float N1=0;
   float N2=0;
   int8  rTemp=0;
   int16 rTemp16=0;
   int8  rTempPant=0; //tiempo en segundos que queda la pantala de prod gral
//++++++++++++++++++Configura puertos analogicos++++++++++++++++++++++++++++++
   setup_adc(  ADC_OFF  );
   setup_adc_ports( NO_ANALOGS );                
//++++++++++++++++++       Configura timers     ++++++++++++++++++++++++++++++
   setup_comparator(NC_NC_NC_NC);               //no comparadores
   setup_timer_0(RTCC_INTERNAL|RTCC_DIV_256);   //desborda cada 10ms 256 antes
   setup_timer_2 (T2_DIV_BY_16, 250, 16);       //setup_timer_2 (T2_DIV_BY_4, 250, 16);

   //Seteos puertos
   set_tris_a (0b11111111);
   output_a(0);
   output_b(0);
   set_tris_b (0b00000001);
   output_c(0);
   set_tris_c (0b11011000);
   
   //********************************************
   ModbusAddress=11;//direccion modbus del cartel
   //********************************************
   
   rT1s=k1seg;
   rT100ms=k100ms;
   
   lee_EEPROM();
   rObjHsAnt=rObjHs;                            //igualo objetivo horario para saber cuando lo cambia
   
   set_timer0(60);
   enable_interrupts(int_rda);                  // Habilita Interrupción RDA
   enable_interrupts(int_RTCC);                 // Habilita Interrupción TIMER0
   enable_interrupts(int_TIMER2);               // Habilita Interrupción TIMER2   

   output_b(0);
   output_high(pOE_SR);
   output_low(pMR_SR);
   output_high(pBUZZ);
   ds1307_init();
   delay_ms(30);
   output_high(pMR_SR);
   ds1307_read ();
   inc_dig();
   envia_disp();
   output_low(pBUZZ);
   
   enable_interrupts(global);                   // Habilita interrupciones
   output_low(pOE_SR);
   rpantalla=0;
   /////////BUCLE PRINCIPAL//////////
   do {
   rMinutosDec = rDec_Min*10 + rUni_Min;                 //extraigo minutos de la hora en decimal
   rMinIniRecDec=(rMiniRec >> 4)*10 +(rMiniRec & 0X0f);  //minutos de inicio del recreo
   rSetDate=rMinIniRecDec;
   
      //si se corto la energia
      if(!input(pin_a4) & !fFinGrabar){
         graba_EEPROM();
         fFinGrabar=1;
      }
      
      //pulsador fin prenda
      IF (fIN1){
         fIN1=0;                 //reset flag
         if (!fRecreo & (rTurnoAct !=0) & !fFiltro){
               rProdHs++;              //incremento cantidad producida
               //rProdAcu++;             //incremento acumulado diario
               rProdTurno++;           //incremento acumulado turno
               rUltTiempo=rAuxTiempo;  //guardo tiempo de ultima prenda
               rAuxTiempo=0;
               fFiltro=1;
               }
      } 
        //pulsador cambio pantalla
      IF (fIN2){
         fIN2=0;                 //reset flag
         if (rPantalla++ == 3)
               rPantalla = 0;
      }     
     
      //si cambio el objetivo horario
      TestCambioOBJ();
      
      if(p1seg){
         p1seg=0;
         ds1307_read ();
         inc_dig();
         envia_disp();
      }    
      //calculos cada 1 minuto
      if (f1Min){
         f1Min=0;
         CalcProd();
         if (rPantalla==2){
            if(--rP2==0){
               rPantalla=0;
               rp2=kP2;
            }
         }
         if(rMinuto==0 && (rTurnoAct !=0))
            fFinHora=1;
      }
      
      //test para ver si cambio de turno
      //se ejecuta cada 1 minuto
      if(fTestTurno){
         fTestTurno=0;
         testTurno ();
         if (rTurnoAct != rTurnoAnt ){
            rTurnoAnt=rTurnoAct;
            //cambio de turno
            if ( rTurnoAct == 0) fFinTurno=1;           
            if(rTurnoAct !=0){
              fIniTurno=1;
            }
         }
         TestRecreo();
      }  
      
       //Suena el timbre al inicio y fin del recreo
      if (fRecreo != fAuxRecreo){
         fAuxRecreo= fRecreo;
         if (fRecreo==0) fFinRecreo=1;
         else fIniRecreo=1;
         fTimbre=1;
      }
      
 //termino turno
      if (fFinTurno){
         fFinTurno=0;
         rProdTurnoAnt=rProdTurno;
         rObjAcuTurnoAnt=rObjAcu;
         rProdTurno=0;
         fTimbre=1;
         rTempObjDia=rObjDia;
         rTempProdTurno=rProdTurnoAnt;
         rTempProdAcu=rProdAcu; 
         rPantalla=2;
         fFinHora=0;   //si fue fin de turno, no hacer fin de hora
      }   
      
      //inicio turno
      if (fIniTurno){
         rProdTurnoAnt=rProdTurno;
         fIniTurno=0;
         rAuxTiempo=0;
         fTimbre=1;
         rAuxTiempo=0;
         rContMin=0;
         rProdHora=0;
         rProdHs=0;              //reset cantidad producida
         rProdAcu=0;             //reset acumulado diario
         rProdTurno=0;           //reset acumulado turno
         fFinHora=0;             //para que no calcule 2 veces el acumulado
         rDatoListo=0;           //para resetear y empezar a contar
         if (rMinutosDec !=0){
               N1=60-rMinutosDec;   //Tiempo productivo de la primer hora
               N1=N1/60;           //fraccion de la hora
               N2=(float)rObjHs;
               N2=N2 * N1;  //prop en lo que falta para fin de la hora con el nuevo objetivo
               rTempObjHs = (int16)N2;
               rObjAcu=rTempObjHs;
               }
         else{
               rObjAcu=rObjHs;
               rTempObjHs = rObjHs;
         }
      }   

      
//se cumplio una hora mas de produccion
      if (fFinHora){
         fFinHora=0;
         fIniRecreo=0;
         rProdHrAnt=rProdHs;//guardo cantidad producida en la hora anterior
         rTempObjHs = rObjHs;
         rProdHs=0;
         //rAuxTiempo=0;
         //calculo rendimiento acumulado
         CalcProd();
         //veo si en esta nueva hora hay recreo para calcular bien el obj acumulado
         if (rHora == rHIniRec){//si en esta hora esta el recreo, calculo cuanto pueden producir hasta el recreo
               N1=(float)rMinIniRecDec;//60;          //fraccion de la hora hasta que empiece el recreo
               N2=rObjHs * N1/60;               //prop en lo que falta para fin de la hora con el nuevo objetivo
               rTempObjHs = (int16)N2;        
               rObjAcu = rObjAcu+rTempObjHs;  //sumo nuevo acumulado para nueva hora
         }
         //veo si en esta nueva hora fin de turno, para cambiar objetivo
         else if (rHora == rHFinTurno){//si en esta hora esta el recreo, calculo cuanto pueden producir hasta el recreo
               N1=(float)rMinFinTurnoDec;//60;          //fraccion de la hora hasta que empiece el recreo
               N2=rObjHs * N1/60;               //prop en lo que falta para fin de la hora con el nuevo objetivo
               rTempObjHs = (int16)N2;        
               rObjAcu = rObjAcu+rTempObjHs;  //sumo nuevo acumulado para nueva hora
         }
         else{// en esta hora no hay recreo, cuento hora total
               rObjAcu = rObjAcu+rTempObjHs;  //sumo nuevo acumulado para nueva hora
               rTempObjHs = rObjHs;
         }
         fPantalla=1;
         rContMin=0;
         rDatoListo++;//=1; //le indica al scada que recolecte el dato
      }  
//si iniicio el recreo
//ejecutar esto solo si el recreo no inicia al mismo tiempo que el fin de una
//hora
      if (fIniRecreo){
         fIniRecreo=0;
         rProdHrAnt=rProdHs;//guardo cantidad producida en la hora anterior
         rProdHs=0;
         rDatoListo++;//=1; //le indica al scada que recolecte el dato
      }
      //si termino el recreo
      if (fFinRecreo){
      fFinRecreo=0;
      //tengo que ver si termino al inicio de la hora, si no, tengo que calcular los
      ///objetivos de la hora
         if(rMinutosDec != 0){                     //si termino distinto de cero, calculo objetivo hasta terminar esta hora
                                                   //si igual a cero, no hacer nada, porque se hace en fin de hora (creo)
               N1=(float)(60-rMinutosDec)/60;           //fraccion de la hora
               N2=(float)rObjHs * N1;              //prop en lo que falta para fin de la hora con el nuevo objetivo
               rTempObjHs = (int16)N2;  
               rObjAcu = rObjAcu+rTempObjHs;       //sumo nuevo acumulado para nueva hora
         }
      }
      
     
      //comunicacion modbus
       if(flagcommand){         // Si hay comando pendiente lo procesa
         ModBus_exe();        
         flagcommand=0;
         inicbuffRX();
         rxpuntero=0; 
      }
      //controla si cambio de turno
      if(rUni_MinAnt != rUni_Min){  //controla si cambio de turno solo si hay cambio en el minuto del reloj
         rUni_MinAnt=rUni_Min;      //asi esta rutina se ejecuta teoricamente cada 1 minuto
         fTestTurno=1;
         f1Min=1;
      }
      
   
      //comando enviado desde PC
      if (rCMD!=0){
         switch (rCMD){
                  case 1: //ajustar hora
                        ds1307_Write_time(0x00, (int8)(rSetTime & 0x00ff), (int8)(rSetTime >>8));
                        break;
                  default:
                        break;       
         }//end switch CMD
         rCMD=0;
      } 
      
      //si hay que accionar el timbre
      if (fTimbre){
         fAlarma=1;
         fTimbre=0;
         rTemp=rSegundos;
         rTemp +=3;
         if (rTemp >= 60)
            rTemp=rTemp-60;
      }
      //mostrar pantalla resumenes cada hora
      if (fPantalla){
         rPantalla=1;
         fPantalla=0;
         fPantTemp=1;
         rTempPant = rSegundos + 10;
         if (rTempPant > 60)
            rtemppant= rtemppant-60;
         }
      
      //cambiar pantalla por 10 segundos
      if (fPantTemp){
         if(rTempPant == rSegundos){
            rPantalla=0;
            fPantTemp=0;
         }
      }
      //encender alarma y apagar pasado el tiempo configurado
      if (fAlarma){
         output_high(pBuzz);
         if(rTemp == rSegundos){
            output_low(pBuzz);
            fAlarma=0;
         }
      }
   } while (TRUE);//fin bucle infinito
}


//envio todos los datos al display
//17 bytes
void envia_disp(void){
int8 i=0;      //offset del puntero a enviar
int8 rbit=0;   //contador de bits
int8 Data=0;   //dato a enviar
//cargo el puntero con byte a enviar
for (i=0;i<=16;i++){//16
Data=*(&rMilL1+i);   //cargo el primer digito a enviar en DATA
//envio bit a bit el dato
   for (rbit=0;rbit<=7;rbit++){
      if(bit_test(Data,7))
         output_high(pDATA_SR);
      else
         output_low(pDATA_SR);
         
      rotate_left(&Data,1);
      delay_us(10);
      output_high(pDCLK_SR);  //CLOCK EN ALTO
      delay_us(10);
      output_LOW(pDCLK_SR);  //CLOCK EN BAJO
   }
}
output_high(pSCLK_SR);
delay_us(1);
output_low(pSCLK_SR);
output_high(pDATA_SR);
}

void inc_dig (void){
//int8 temp=0;
//1ra linea de digitos
switch (rPantalla){
      case 0:  //datos horarios 1 linea: cant horaria, 2 linea  obj horario, 3 linea: porcentaje
            Dec_A_UDCU(rProdHs);//rTempObjHs);//rTempObjHs);//Objetivo horario rObjHs
            rUniL1=dec_bcd[rUni];
            rDecL1=dec_bcd[rDec];
            rCenL1=dec_bcd[rCent];
            rMilL1=dec_bcd[rUMil];
            //2da linea de digitos
            Dec_A_UDCU(rTempObjHs);//rProdHs);//producido horario
            rUniL2=dec_bcd[rUni];
            rDecL2=dec_bcd[rDec];
            rCenL2=dec_bcd[rCent];
            rMilL2=dec_bcd[rUMil];
            //3da linea de digitos
            Dec_A_UDCU(rProdHora);//rProdHora);//producido horario
            rUniL3=dec_bcd[rUni];
            rDecL3=dec_bcd[rDec];
            rCenL3=dec_bcd[rCent];
            rMilL3=dec_bcd[rUMil];
            //bit_clear(rUniL3,7);
            rLeds=255;
            break;
      case 1: //datos diarios
            Dec_A_UDCU(rProdTurno);//rObjDia);//objetivo diario
            rUniL1=dec_bcd[rUni];
            rDecL1=dec_bcd[rDec];
            rCenL1=dec_bcd[rCent];
            rMilL1=dec_bcd[rUMil];
            //2da linea de digitos
            Dec_A_UDCU(rObjAcu);//produccion turno
            rUniL2=dec_bcd[rUni];
            rDecL2=dec_bcd[rDec];
            rCenL2=dec_bcd[rCent];
            rMilL2=dec_bcd[rUMil];
            //3da linea de digitos
            Dec_A_UDCU(rProdAcu);//productividad acumulada
            rUniL3=dec_bcd[rUni];
            rDecL3=dec_bcd[rDec];
            rCenL3=dec_bcd[rCent];
            rMilL3=dec_bcd[rUMil];
            //bit_clear(rUniL3,7);
            rLeds=254;
            break;
      case 2: //datos diarios
            Dec_A_UDCU(rTempProdTurno);//temporal objetivo diario
            rUniL1=dec_bcd[rUni];
            rDecL1=dec_bcd[rDec];
            rCenL1=dec_bcd[rCent];
            rMilL1=dec_bcd[rUMil];
            //2da linea de digitos
            Dec_A_UDCU(rObjAcuTurnoAnt);//temporal produccion turno
            rUniL2=dec_bcd[rUni];
            rDecL2=dec_bcd[rDec];
            rCenL2=dec_bcd[rCent];
            rMilL2=dec_bcd[rUMil];
            //3da linea de digitos
            Dec_A_UDCU(rTempProdAcu);//productividad acumulada
            rUniL3=dec_bcd[rUni];
            rDecL3=dec_bcd[rDec];
            rCenL3=dec_bcd[rCent];
            rMilL3=dec_bcd[rUMil];
            //bit_clear(rUniL3,7);
            rLeds=252;
            break;
      default:break;
}//fin switch
//4da linea de digitos (hora)
rUniL4=dec_bcd[rUni_Min];
rDecL4=dec_bcd[rDec_Min];
rCenL4=dec_bcd[rUni_HS];
rMilL4=dec_bcd[rDec_HS];
//leds pirania
//rLeds=dec_bcd[0];
rtemp=10;
if (bit_test(rUni_SEc,0))
   bit_set(rDecL4,7);
else
   bit_clear(rDecL4,7); //rCentL4
}

VOID ds1307_init(void){
int8 seconds=0;
   i2c_start();
   i2c_write(0xD0);
   i2c_write(0x00);
   i2c_start();
   i2c_write(0xD1);
   seconds = i2c_read(0);
   i2c_stop();
   seconds &= 0x7F;

   delay_us(3);

   i2c_start();
   i2c_write(0xD0);
   i2c_write(0x00);
   i2c_write(seconds);
   i2c_start();
   i2c_write(0xD0);
   i2c_write(0x07);
   i2c_write(0);
   i2c_stop();
}

void ds1307_read (void){
int8 rTempDS=0;
   I2C_Start();
   I2C_Write(0xd0); 
   i2c_write(0x00);
   I2C_Start();
   i2c_write(0xd1);
   rTempDS=i2c_read();//leo segundos 
   rUni_SEC= rTempDs & 0x0f;
   rDec_SEC= swap(rTempDS)& 0x0f; 
   rSegundos=(rDec_Sec*10)+rUni_Sec;//asumo que no es en BCD
   rTempDS=i2c_read();//leo minutos 
   rUni_Min= rTempDs & 0x0f;            
   rDec_Min= swap(rTempDS) & 0x0f;
   rMinuto= rDec_Min;
   rMinuto= rMinuto *16 + rUni_Min;
   rTempDS=i2c_read(0);//leo horas 
   rUni_HS= rTempDs & 0x0f;            
   rDec_HS= swap(rTempDS) & 0x03; 
   rHora= rDec_HS *16 + rUni_Hs;
   i2c_stop();
   rTime= rHora << 8;
   rTime=rTime + rMinuto;
}

void ds1307_Write_time(int8 sec, int8 min, int8 hs){
   i2c_start();
   i2c_write(0xD0);
   i2c_write(0x00);
   i2c_write(sec);
   //i2c_start();
   i2c_write(min);
   //i2c_start();
   i2c_write(hs);   
   i2c_start();
   i2c_write(0xD0);
   i2c_write(0x07);
   i2c_write(0);
   i2c_stop();
}

void TestTurno(void){
int8 rHini=0;
int8 rMini=0;
int8 rHfin=0;
int8 rMfin=0;
//controlo si esta turno 1
//hora inicio
rHini = make8(rIniT1,1);
rMini = make8(rIniT1,0);
//hora fin
rHfin = make8(rFinT1,1);
rMfin = make8(rFinT1,0);
if (rTurnoAct == 1){
   rHFinTurno =rHfin;
   rMinFinTurnoDec=(rMfin >> 4)*10 +(rMfin & 0X0f);  //minutos de fin de turno
}
//controlar inicio turno1
if ((rHora == rHini) & (rMinuto == rMini) & (rTurnoAct != 1)){
   rTurnoAct= 1;
   return;
}
//controlar fin turno 1
if (rTurnoAct == 1){
   if((rHora == rHfin) & (rMinuto == rMfin)){
      rTurnoAct= 0;
   }
}

//controlo si esta turno 2
//hora inicio
rHini = make8(rIniT2,1);
rMini = make8(rIniT2,0);
//hora fin
rHfin =make8(rFinT2,1);
rMfin = make8(rFinT2,0);
if (rTurnoAct == 2){
   rHFinTurno =rHfin;
   rMinFinTurnoDec=(rMfin >> 4)*10 +(rMfin & 0X0f);  //minutos de fin de turno
}
//controlar turno1
//controlar inicio turno1
if ((rHora == rHini) & (rMinuto == rMini) & (rTurnoAct != 2)){
   rTurnoAct= 2;
   return;
}
//controlar fir turno 1
if (rTurnoAct == 2){
   if((rHora == rHfin) & (rMinuto == rMfin)) rTurnoAct= 0;
}
//controlo si esta turno 3
//hora inicio
rHini = make8(rIniT3,1);
rMini = make8(rIniT3,0);
//hora fin
rHfin = make8(rFinT3,1);
rMfin =make8(rFinT3 ,0);
if (rTurnoAct == 3){
   rHFinTurno =rHfin;
   rMinFinTurnoDec=(rMfin >> 4)*10 +(rMfin & 0X0f);  //minutos de fin de turno
}
//controlar inicio turno1
if ((rHora == rHini) & (rMinuto == rMini) & (rTurnoAct != 3)){
   rTurnoAct= 3;
   return;
}
//controlar fir turno 1
if (rTurnoAct == 3){
   if((rHora == rHfin) & (rMinuto == rMfin)) rTurnoAct= 0;
}
//controlo si esta turno 4
//hora inicio

rHini = make8(rIniT4,1);
rMini = make8(rIniT4,0);
//hora fin
rHfin = make8(rFinT4,1);
rMfin =make8(rFinT4,0);
if (rTurnoAct == 4){
   rHFinTurno =rHfin;
   rMinFinTurnoDec=(rMfin >> 4)*10 +(rMfin & 0X0f);  //minutos de fin de turno
}
//controlar inicio turno4
if ((rHora == rHini) & (rMinuto == rMini) & (rTurnoAct != 4)){
   rTurnoAct= 4;
   return;
}
//controlar fir turno 4
if (rTurnoAct == 4){
   if((rHora == rHfin) & (rMinuto == rMfin)) rTurnoAct= 0;
}
//rTurnoAct= 0;
}

void TestRecreo(void){
int8 rHini=0;
int8 rMini=0;
int8 rHfin=0;
int8 rMfin=0;
//fRecreo= 0;
//hora inicio
if (rTurnoAct == 1){
   rHini = make8(rIniRecT1,1);
   rMini = make8(rIniRecT1,0);
   rHIniRec=rHini;
   rMIniRec=rMini;
   //hora fin
   rHfin = make8(rFinRecT1,1);
   rMfin = make8(rFinRecT1,0);
   //controlar recreo 1
/*   if ((rHora >= rHini) & (rMinuto >= rMini) & (rHora <= rHfin) & (rMinuto < rMfin)){
      fRecreo= 1;
      return;
   }*/
}
if (rTurnoAct == 2){
   //controlo si esta turno 2
   //hora inicio
   rHini = make8(rIniRecT2,1);
   rMini = make8(rIniRecT2,0);
   rHIniRec=rHini;
   rMIniRec=rMini;
   //hora fin
   rHfin = make8(rFinRecT2,1);
   rMfin = make8(rFinRecT2,0);
   //controlar recreo 2
/*   if ((rHora >= rHini) & (rMinuto >= rMini) & (rHora <= rHfin) & (rMinuto < rMfin)){
      fRecreo= 1;
       return;
   }*/
}
if (rTurnoAct == 3){
      //controlo si esta turno 3
   //hora inicio
   rHini = make8(rIniRecT3,1);
   rMini = make8(rIniRecT3,0);
   rHIniRec=rHini;
   rMIniRec=rMini;
   //hora fin
   rHfin = make8(rFinRecT3,1);
   rMfin = make8(rFinRecT3,0);
   //controlar recreo 3
/*   if ((rHora >= rHini) & (rMinuto >= rMini) & (rHora <= rHfin) & (rMinuto < rMfin)){
      fRecreo= 1;
       return;
   }*/
   
}
if (rTurnoAct == 4){
   //controlo si esta turno 4
   //hora inicio
   rHini = make8(rIniRecT4,1);
   rMini = make8(rIniRecT4,0);
   rHIniRec=rHini;
   rMIniRec=rMini;
   //hora fin
   rHfin = make8(rFinRecT4,1);
   rMfin = make8(rFinRecT4,0);
   //controlar recreo 4
/*   if ((rHora >= rHini) & (rMinuto >= rMini) & (rHora <= rHfin) & (rMinuto < rMfin)){
      fRecreo= 1;
      return;
   }*/
}
   if ((rHora == rHini) & (rMinuto >= rMini)){
      fRecreo= 1;
   }
   if ((rHora == rHfin) & (rMinuto >= rMfin)){
      fRecreo= 0;
   }   
   rIniRecredo = rMini;
}

//descompone un numero en unidad de mil, centena, decena y unidad
//retorna esos valores en variables globales rUMil, rCent, rDec, rUni
void Dec_A_UDCU(int16 nro){
if (nro > 9999)nro = 0;
rUMil = (int8)(nro/1000);
rCent = (int8)(nro/100 - rUMil*10);
rDec  = (int8)(nro/10 - rCent * 10 - rUmil *100);
rUni  = (int8)(nro - rUmil * 1000 - rCent *100 - rDec * 10);

if (rUMil == 0) rUMil = 10; // borrar cero
else return;
if (rCent == 0) rCent = 10; // borrar cero
else return; 
if (rDec == 0) rDec = 10; // borrar cero
else return;
}

vOID WRITE_WORD_EEPROM(long int Dir, int16 data) {
   int i;
   for (i = 0; i < 2; i++){
     write_eeprom(i + Dir, *((int8)&data + i) ) ;
   }
}

INT16 READ_WORD_EEPROM(long int n) {
   int i;
   int16 data;
   for (i = 0; i < 2; i++){
     *((int8)&data + i) = read_eeprom(i + n);
   }
   return(data);
}

void graba_EEPROM(void){
long int Data=0;
int8 EE_Add=0;    //direccion inicial en eeprom
Data= &rProdHs; //direccion de memoria en el micro.

for (EE_Add=0;EE_Add <=64;EE_Add ++){
   write_eeprom(EE_Add, *((int8)Data + EE_Add) ) ;

}//end for
}

void lee_EEPROM(void){
long int Data=0;
int8 EE_Add=0;    //direccion inicial en eeprom
Data= &rProdHs; //direccion de memoria en el micro.

for (EE_Add=0;EE_Add <=64;EE_Add ++){
  *((int8)Data + EE_Add)=read_eeprom(EE_Add) ;

}//end for
}

void CalcProd(void){
float N1=0;
float N2=0;
float rCalc=0;
         N1=(float)rProdHs;
         N2=(float)rTempObjHs;
         if (N2 > 0) rCalc = N1/N2;
         rProdHora = (int16)(rCalc*1000); 
         //productividad turno
         N1=(float)rProdTurno;
         N2=(float)rObjAcu;
         rCalc = N1/N2;         
         rProdAcu=(int16)(rCalc*1000);//productuvidad acumulada
}

void TestCambioOBJ (void){
int16 rTemp16=0;
float N1=0;
float N2 =0;
      if (rObjHsAnt != rObjHs){ 
         if(rTurnoAct!=0 & !fRecreo){
            rTemp16=rTempObjHs;
            if ((rHora == rHIniRec) & (rMinutosDec < rMIniRec))//si hay recreo en esta hora
                 N1= (float)rMinIniRecDec;
            else if (rHora == rHFinTurno)
                 N1= (float)rMinFinTurnoDec;
            else 
                 N1=60.0;  
                 
           N1 = (N1-(Float)rMinutosDec)/N1; 
           N2 = (float)rTempObjHs - (float)rObjHsAnt*N1 + (float)rObjHs * N1; 
           rTempObjHs=(int16)N2;
           rObjAcu = rObjAcu - rTemp16 + rTempObjHs;        
         }
         rObjHsAnt=rObjHs;       //igualo   
      }
}
