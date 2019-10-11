package br.com.alura.bytebank.converter

import java.sql.Timestamp
import java.time.LocalDateTime
import javax.persistence.AttributeConverter
import javax.persistence.Converter

@Converter
class LocalDataTimeConverter : AttributeConverter<LocalDateTime, Timestamp> {

    override fun convertToDatabaseColumn(data: LocalDateTime?) =
            data?.let { Timestamp.valueOf(data) }

    override fun convertToEntityAttribute(valor: Timestamp?) =
            valor?.let { valor.toLocalDateTime() }

}