class SistemaBancario:

    def __init__(self):

        self.saldo = 0
        self.extrato = ''
        self.limite_saque = 500
        self.num_saques = 0

    def depositar(self, valor):

        if valor > 0:
            self.saldo += valor
            self.extrato += f'Depósito: + R$ {"%.2f" % valor} \n'
        else:
            print('Valor inválido! Por favor, digite um valor maior que R$ 0')

    def sacar(self, valor):

        if self.saldo > 0:
            if valor <= self.limite_saque:
                if self.num_saques != 3:
                    self.saldo -= valor
                    self.extrato += f'Saque: - R$ {"%.2f" % valor}\n '
                    self.num_saques += 1
                else:
                    print('Operação negada! O limite de saques foi excedido.')
            else:
                print('Operação negada! O limite para saque é de R$ 500.00')
        else:
            print('Não é possivel sacar! A conta não possui saldo disponível para saque.')

    def gerar_extrato(self):

        print('====================== EXTRATO =======================')
        print('\nNão foram realizadas movimentações' if not self.extrato else self.extrato)
        print(f'Saldo: R$ {"%.2f" % self.saldo}')
        print('======================================================')
