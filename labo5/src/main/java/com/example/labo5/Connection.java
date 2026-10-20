
package com.example.labo5;

import alice.tuprolog.Prolog;
import alice.tuprolog.SolveInfo;
import alice.tuprolog.Theory;

import java.io.InputStream;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Connection {
    private final Prolog engine = new Prolog();

    public Connection() throws Exception {
        try (InputStream in = getClass().getResourceAsStream("/calculo.pl")) {
            if (in == null) {
                throw new IllegalStateException("No se encontró calculo.pl");
            }
            engine.setTheory(new Theory(in));
        }
    }

    public String consultar(String predicado, String expresion) throws Exception {
        Matcher matcher = Pattern.compile("^\\s*(-?\\d+)\\s*([+-])\\s*(-?\\d+)\\s*$")
                .matcher(expresion);

        if (!matcher.matches()) {
            throw new IllegalArgumentException(
                    "Ingresá una operación válida, por ejemplo 10+5 o 10-5"
            );
        }

        int a = Integer.parseInt(matcher.group(1));
        String operador = matcher.group(2);
        int b = Integer.parseInt(matcher.group(3));



        if (predicado.equals("suma") && !operador.equals("+")) {
            throw new IllegalArgumentException("Para sumar, utilizá el operador +");
        }

        if (predicado.equals("resta") && !operador.equals("-")) {
            throw new IllegalArgumentException("Para restar, utilizá el operador -");
        }

        String consulta = predicado + "(" + a + ", " + b + ", R).";
        SolveInfo info = engine.solve(consulta);

        return info.isSuccess()
                ? info.getTerm("R").toString()
                : "Sin solución para esa operación";
    }
}
