from bank_system import SistemaBancario

menu = """
================================= MENU ==================================
[1] - Depósito
[2] - Saque
[3] - Extrato
[4] - Sair

"""
op = SistemaBancario()

while True:

    opcao = int(input(menu))

    if opcao == 1:
        valor = float(input('Digite o valor a ser depositado: R$ '))
        op.depositar(valor)

    elif opcao == 2:
        valor = float(input('Digite o valor a ser sacado: R$ '))
        op.sacar(valor)

    elif opcao == 3:
        op.gerar_extrato()

    elif opcao  == 4:
        break

    else:
        print('Opção inválida! Por favor, tente novamente.')
