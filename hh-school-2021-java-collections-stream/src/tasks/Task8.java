package tasks;

import common.Person;
import common.Task;

import java.time.Instant;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/*
А теперь о горьком
Всем придется читать код
А некоторым придется читать код, написанный мною
Сочувствую им
Спасите будущих жертв, и исправьте здесь все, что вам не по душе!
P.S. функции тут разные и рабочие (наверное), но вот их понятность и эффективность страдает (аж пришлось писать комменты)
P.P.S Здесь ваши правки желательно прокомментировать (можно на гитхабе в пулл реквесте)
 */
public class Task8 implements Task {

  //Не хотим выдывать апи нашу фальшивую персону, поэтому конвертим начиная со второй
  public List<String> getNames(List<Person> persons) {
    // понял вроде намек про одну персону, надеюсь, что правильно понял
    if (persons.size() == 0) {
      return Collections.emptyList();
    }
    // вернул пропуск первого элемента
    return persons.stream().skip(1).map(Person::getFirstName).collect(Collectors.toList());
  }

  //ну и различные имена тоже хочется
  public Set<String> getDifferentNames(List<Person> persons) {
    // зачем тут стрим по уникальным, так еще и в сет потом,
    // так что просто сразу сет делаю
    return new HashSet<>(getNames(persons));
  }

  //Для фронтов выдадим полное имя, а то сами не могут
  public String convertPersonToString(Person person) {
    // если мы проверяем методы на выдачу нул, то имхо стоит
    // возвращаю null, а не "null"
    if (person == null) return null;

    // так вроде симпатичнее стало, + проверка на нулл
    // так что теперь и при ФИО и при ФИ работает норм
    return Stream.of(person.getSecondName(), person.getFirstName(), person.getMiddleName())
            .filter(Objects::nonNull)
            .collect(Collectors.joining(" "));
  }

  // словарь id персоны -> ее имя
  public Map<Integer, String> getPersonNames(Collection<Person> persons) {
    // убрал проверку на null
    return persons.stream()
            .collect(Collectors.toMap(
                    Person::getId,
                    this::convertPersonToString,
                    (a, b) -> a
            ));
  }

  // есть ли совпадающие в двух коллекциях персоны?
  public boolean hasSamePersons(Collection<Person> persons1, Collection<Person> persons2) {
    // учел фидбек и исправил
    return persons1.stream()
            .anyMatch(new HashSet<>(persons2)::contains);
  }

  //...
  public long countEven(Stream<Integer> numbers) {
    // убрал поле у класса и сделал метод короче и понятнее
    return numbers.filter(x -> x % 2 == 0).count();
  }

  @Override
  public boolean check() {
    boolean codeSmellsGood = true;
    String reviewerDrunk = "кто ж знает";
    return codeSmellsGood;
  }
}
