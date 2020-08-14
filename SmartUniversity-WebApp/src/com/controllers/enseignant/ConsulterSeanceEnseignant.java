package com.controllers.enseignant;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.helpers.SeanceResponse;

@WebServlet("/User/ConsulterSeanceEnseignant")
public class ConsulterSeanceEnseignant extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ConsulterSeanceEnseignant() {
        super();
    }
    
    @SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		ConsulterSeancesEnseignant.UpadteSeancesFromAPI(session);
		String code_seance = request.getParameter("code-seance");
		ArrayList<SeanceResponse> seances = (ArrayList<SeanceResponse>) session.getAttribute("seances");
		SeanceResponse seance = SeanceResponse.GetByCodeSeance(seances, code_seance);
		session.setAttribute("seance", seance);
		request.getRequestDispatcher("/WEB-INF/espace_enseignant/consulter_seance_enseignant.jsp").forward(request, response);
	}
}
