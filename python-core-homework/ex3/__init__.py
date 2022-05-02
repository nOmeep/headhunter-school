from ex3.available_actions import NOTHING_ACTION


def determine_winner(player1, player2):
    """
    Функция определяет победителя в игре камень, ножницы, бумага

    :param player1: первый игрок
    :param player2: второй игрок
    :return: Игрок победитель или None, если победителя не удалось определить
    """

    if NOTHING_ACTION in (player1.action, player2.action):
        print('Один или несколько игроков ничего не выбрали.', repr(player1), repr(player2))
        return None

    print(f'{repr(player1)} против {repr(player2)}')

    if player1.action == player2.action:
        print('Ничья')
        return None

    winner = player1 if player1.action > player2.action else player2
    print(f'Победил {winner}')

    return winner
