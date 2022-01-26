// SPDX-License-Identifier: MIT

pragma solidity ^0.4.19;

contract ZombieFactory { //Cоздаем контракт
    
    event NewZombie(uint zombieId, string name, uint dna); // Объявляем событие для внешнего приложения
    
    uint dnaDigits = 16;   //ДНК зомби будет определяться номером из 16 цифр
    uint dnaModulus = 10 ** dnaDigits; 
        /** 
        Чтобы убедиться, что ДНК зомби составляет всего 16 символов,
        создадим еще один uint со значением 10^16. Таким образом, мы сможем позже использовать 
        оператор модуля % для сокращения целого числа до 16 цифр
        Модуль и остаток от деления: x % y (например, 13 % 5 будет равно 3, если разделить 13 на 5, в остатке 3)
        */
    struct Zombie { // Создаем объект Zombie и определяем его структуру
        string name;
        uint dna;
    }
    Zombie[] public zombies; 
        /**
        Создаем динамический массив типа структуры Zombie[] не ограниченый по размеру 
        и он может увеличиваться. Назовем массив zombies
        */  
    function _createZombie(string _name, uint _dna) private {
            uint id = zombies.push(Zombie(_name, _dna)) - 1;
            NewZombie(id, _name, _dna);
    } 
        /** функция _createZombie
        Создаем функцию под названием createZombie (создать зомби), которая берет 2 параметра:
        _name (имя, строка string) и _dna (ДНК, тип uint)
        с помощью zombies.push добавляем новый объект Zombie (типа структура) в конец массива
        с именем zombies, при этом .push ничего не возвращает
        */
        /**
        Нужно каждый раз сообщать внешнему интерфейсу о создании нового зомби, чтобы приложение могло его отобразить.
        Задай event (событие) под названием NewZombie (новый зомби). Оно должно сообщать zombieId (uint), 
        имя name (строку string) и ДНК dna (uint).
        событие NewZombie запускается после добавления нового солдата в массив zombies.
        id — идентификатор зомби. array.push() возвращает uint новой длины массива. 
        Поскольку первый элемент в массиве имеет индекс 0, array.push () - 1 вернет индекс 
        только что добавленного зомби. Сохрани результат zombies.push () - 1 в uint с названием id,
        чтобы его можно было использовать в событии NewZombie в следующей строчке.
        */
    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }
        /** функция _generateRandomDna
        Чтобы сгенерировать случайную ДНК для этого нужно:
        Первая строчка кода должна взять keccak256-хэш от _str, 
        чтобы сгенерировать превдослучайное шестнадцатеричное число, 
        преобразовать его в uint и сохранить результат в uint с именем rand.
        Мы хотим, чтобы зомби-ДНК содержала только 16 цифр (выше есть dnaModulus). 
        Поэтому следующая строчка кода должна return (возвращать) вычисленное выше 
        значение модуля (%) dnaModulus.
        */ 
    function createRandomZombie(string _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
        /** функция createRandomZombie - публичная функция, 
        которая получает на вход параметр "имя зомби" и использует его, 
        чтобы создать зомби со случайной ДНК
        Первая строчка в коде функции должна вызывать _generateRandomDna(сгенерировать случайную ДНК)
        в _name (имя), и сохранять ее в uint под названием randDna (случайная ДНК).
        Вторая строчка кода вызывает функцию _createZombie (создать зомби) и сообщает ей _name(имя) 
        и randDna (случайную ДНК).
        */ 
}
