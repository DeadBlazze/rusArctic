<template lang="pug">
.contacts
    <h1>Контакты</h1>
    .contacts__map
        img(src='../../assets/images/contacts/contacts_map.png')
        p
            | Федеральное государственное бюджетное учреждение «Национальный парк «Русская Арктика»
            <br><br>
            | Россия, 163051, г. Архангельск, наб. Северной Двины, д. 36
            <br><br>
            | Тел. +7 (8182) 65-38-58
            | e-mail: rus-arc@rus-arc.ru
    .contacts__person
        .contacts__person-card(v-for="person in this.persons" :key="person.id")
            .contacts__person-img
                img(:src="getImageSrc(person.image)")
            .contacts__person-text
                p.position {{person.position}}
                p.fio {{person.fio}}  
                .tel
                    img(src='../../assets/images/contacts/icons/email.svg') 
                    p {{person.tel}}
                .email
                    img(src='../../assets/images/contacts/icons/tel.svg')
                    p {{person.email}}
</template>
<script>
export default {
    data() {
        return {
            persons : [
                {   id:1,
                    fio: "Кирилов Александр Георгиевич",
                    position: 'Директор',
                    tel: '+7 (8182) 65-38-58', 
                    email: "kirilov@rus-arc.ru",
                    image: '1.png'
                },
                {   id:2,
                    fio: "Ануфриева Анна Сергеевна",
                    position: 'Секретарь руководителя',
                    tel: '+7 (8182) 65-38-58', 
                    email: "rus-arc@rus-arc.ru",
                    image: '2.png'
                },
                {   id:3,
                    fio: "Меньшикова Марина Владимировна",
                    position: 'Пресс-секретарь',
                    tel: '+7 (8182) 65-38-58', 
                    email: "menshikova@rus-arc.ru",
                    image: '3.png'
                },
                {   id:4,
                    fio: "Кунников Андрей Васильевич",
                    position: 'Заместитель директора по экологическому просвещению и туризму',
                    tel: '+7 (8182) 65-38-58', 
                    email: "kunnikov@rus-arc.ru",
                    image: '4.png'
                },
                {   id:5,
                    fio: "Перхуров Роман Александрович",
                    position: 'Заместитель директора по развитию',
                    tel: '+7 (8182) 65-28-99', 
                    email: "perkhurov@rus-arc.ru",
                    image: '5.png'
                },
                {   id:6,
                    fio: "Мизин Иван Андреевич",
                    position: 'Заместитель директора по научной работе',
                    tel: '+7 (8182) 65-38-58', 
                    email: "mizin@rus-arc.ru",
                    image: '6.png'
                },
                {   id:7,
                    fio: "Кулакова Юлия Ивановна",
                    position: 'Заместитель директора по финансам главный бухгалтер',
                    tel: '+7 (8182) 65-38-58', 
                    email: "perkhurov@rus-arc.ru",
                    image: '7.png'
                },
                {   id:8,
                    fio: "Кабанихина Александра Николаевна",
                    position: 'Начальник отдела экологического просвещения и туризма',
                    tel: '+7 (8182) 65-37-71', 
                    email: "kan@rus-arc.ru",
                    image: '8.png'
                },
                {   id:9,
                    fio: "Ермолов Евгений Олегович",
                    position: 'Начальник отдела сохранения историко-культурного наследия',
                    tel: '+7 (8182) 65-38-58', 
                    email: "ermolov@rus-arc.ru",
                    image: '9.png'
                },
                {   id:10,
                    fio: "Скуратович Елена Викторовна",
                    position: 'Начальник отдела кадров и делопроизводства',
                    tel: '+7 (8182) 65-38-58', 
                    email: "hr@rus-arc.ru",
                    image: '10.png'
                },
                {   id:11,
                    fio: "Захарьин Вадим Евгеньевич",
                    position: 'Начальник отдела охраны',
                    tel: '+7 (8182) 65-38-58', 
                    email: "zaharin@rus-arc.ru",
                    image: '11.png'
                },
                {   id:12,
                    fio: "Котрехов Игорь Анатольевич",
                    position: 'Руководитель группы по управлению имуществом',
                    tel: '+7 (8182) 65-58-90', 
                    email: "kotrehov@rus-arc.ru",
                    image: '12.png'
                }
            ]
            
        }
    },
    methods: {
        getImageSrc(image){
            return new URL(`../../assets/images/contacts/person/${image}`, import.meta.url).href
        }
    }
}
</script>
<style lang="scss" scoped>
    @use './contacts.scss' as *
</style>