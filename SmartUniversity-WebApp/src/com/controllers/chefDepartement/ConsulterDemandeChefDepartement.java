package com.controllers.chefDepartement;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.helpers.DemandeChangementSeanceResponse;
import com.helpers.DemandeCongeAcademiqueResponse;
import com.helpers.DemandeSeanceSuppResponse;
import com.helpers.DemandesDepartementResponse;

@WebServlet("/User/ConsulterDemandeChefDepartement")
public class ConsulterDemandeChefDepartement extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	public static final String DEMANDE_SEANCE_SUPP = "supp";
	public static final String DEMANDE_CHANGEMENT_SEANCE = "changement";
	public static final String DEMANDE_CONGE_ACADEMIQUE = "conge";
	
    public ConsulterDemandeChefDepartement() 
    {
        super();
    }
    
    /*
     * Demande seance supp => supp
     * Demande changement => changement
     * Demande etudiant => conge
     * */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session = request.getSession(false);
		ConsulterDemandesChefDepartement.UpdateDemandesFromAPI(session);
		String typeDemande = request.getParameter("type");
		DemandesDepartementResponse demandesDepartement = (DemandesDepartementResponse) session.getAttribute("demandesDepartement");
		session.setAttribute("typeDemande", typeDemande);

		switch (typeDemande)
		{
		case DEMANDE_SEANCE_SUPP:
			int code_seance_supp = Integer.parseInt(request.getParameter("code-seance-supp"));			
			DemandeSeanceSuppResponse demandeSupp = demandesDepartement.GetDemandeSeanceSuppByCodeSeanceSupp(code_seance_supp);
			session.setAttribute("demande", demandeSupp);
			request.getRequestDispatcher("/WEB-INF/espace_enseignant/espace_chef_departement/consulter_demande_enseignant_chef_departement.jsp").forward(request, response);
			return;
		case DEMANDE_CHANGEMENT_SEANCE:
			String code_seance = request.getParameter("code-seance");
			DemandeChangementSeanceResponse demandeChangement = demandesDepartement.GetDemandeChangementByCodeSeance(code_seance);
			session.setAttribute("demande", demandeChangement);
			request.getRequestDispatcher("/WEB-INF/espace_enseignant/espace_chef_departement/consulter_demande_enseignant_chef_departement.jsp").forward(request, response);
			return;
		case DEMANDE_CONGE_ACADEMIQUE:
			int numero_conge_academique = Integer.parseInt(request.getParameter("numero-conge-academique"));
			DemandeCongeAcademiqueResponse demandeCongeAcademique = demandesDepartement.GetDemandeCongeAcademique(numero_conge_academique);
			session.setAttribute("demande", demandeCongeAcademique);
			request.getRequestDispatcher("/WEB-INF/espace_enseignant/espace_chef_departement/consulter_demande_etudiant_chef_departement.jsp").forward(request, response);
			return;
		default:
			//TODO page d'erreur?
			return;
		}
		
	}
}
